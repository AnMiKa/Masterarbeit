function [ lambda ] = opt_lambdas( s, s_hat, S, d, c, C, U1, U2, R,...
    CC, UU, phi, step, i_C, rho, k )
%OPT_LAMBDAS solves the lambda-subproblem of the variable metric bundle
%method
%   minizes the function
%   phi(l1,l2,l3) = (la*s_hat+l2*s+l3*S)'*D*(l1*s_hat+l2*s+l3*S)+2*(l2*c+l3*C)
%   s.t. l1, l2, l3 >= 0, l1+l2+l3 = 1
%   Function is invoked in every null step to do the aggregation.
%   Implemented after the ideas in "Globally convergent variable metric
%   method nonconvex nondifferentiable unconstrained minimization" by J.
%   Vlcek and L- Luksan.

% input parameters
%   s                       current augmented subgradient
%   s_hat                   augmented subgradient of most recent serious step
%   S                       augmented aggregate subgradient
%   d                       current search direction
%   c                       augmented linearization error
%   C                       augmented aggregate error
%   U1, U2, R, CC, UU, phi  parts for limited memory construction of D
%   step                    saves if D is updated by BFGS or SR1
%   i_C                     indicates correction
%   rho                     correction parameter
%   k                       current step


% output parameters
%   lambda = [lambda1, lambda2, lambda3]

%% BEGINNING of the algorithm
% some precalculations
s_hatS = s_hat - S;
sS = s - S;
ss_hat = s-s_hat;

% test if minimum is within the given bounds
% if yes -> unconstrained optimization by one Newton-step
% if no  -> check minima on the edges of the feasible set

if k == 1
    a = -c/((s_hat'*s)^2/(s_hat'*s_hat)+s'*s);
    if 0 <= a && a <= 1
        l2 = -c/((s_hat'*s)^2/(s_hat'*s_hat)+s'*s);
        l1 = -l2*(s_hat'*s)/(s_hat'*s_hat);
        l3 = 1-l1-12;
    else
       l2 = min(1,max(0,-c/(s'*s)));
       l1 = 0;
       l3 = 1-l2;
    end
    lambda = [l1,l2,l3];
else
    SS = [s_hat, s, S];
    r = [0 c C]';
    DS = Dv(SS, U1, U2, R, UU, CC, phi, step, i_C,rho);
    SDS = SS'*DS;
    Ds1 = Dv(s_hatS, U1, U2, R, UU, CC, phi, step, i_C,rho);
    sDs1 = sS'*Ds1;
    sDs2 = s_hatS'*Ds1;
    if (C*sDs1) == ((C-c)*sDs2)
        if cond(SDS) > 1e10
            [u,si,v] = svd(SDS,'econ');
            for i = size(si):-1:1
                if abs(si(i,i)) <= 1e-10
                    v(i,:) = [];
                    si(:,i) = [];
                end
            end 
            SS = u*si*v;
            DS = Dv(SS, U1, U2, R, UU, CC, phi, step, i_C,rho);
            SDS = SS'*DS;
        end
        lambda = -SDS\r;
    else
        if norm(s_hatS) > 1e-5
            l1 = min(1,max(0,(d'*s_hatS+C)/sDs2));
        elseif C < 0
            l1 = 0;
        else
            l1 = 1;
        end
        if norm(sS) > 1e-5
            Ds3 = Dv(sS, U1, U2, R, UU, CC, phi, step, i_C,rho);
            sDs3 = sS'*Ds3;
            l2 = min(1,max(0,(d'*sS+C-c)/sDs3));
        elseif C < c
            l2 = 0;
        else
            l2 = 1;
        end
        if norm(ss_hat) > 1e-5
            Ds4 = Dv(ss_hat, U1, U2, R, UU, CC, phi, step, i_C,rho);
            sDs4 = ss_hat'*Ds4;
            d_hat = -Dv(s_hat, U1, U2, R, UU, CC, phi, step, i_C,rho);
            l2_2 = min(1,max(0,(d_hat'*ss_hat-c)/sDs4));
        elseif c > 0
            l2_2 = 0;
        else 
            l2_2 = 1;
        end
        lambda1 = [l1, 0, 1-l1]';
        lambda2 = [0, l2, 1-l2]';
        lambda3 = [1-l2_2, l2_2, 0]';
        phi1 = lambda1'*SDS*lambda1+2*r'*lambda1;
        phi2 = lambda2'*SDS*lambda2+2*r'*lambda2;
        phi3 = lambda3'*SDS*lambda3+2*r'*lambda3;

        [~,i] = min([phi1,phi2,phi3]);

        if i == 1
            lambda = lambda1;
        elseif i == 2
            lambda = lambda2;
        else
            lambda = lambda3;
        end
    end
end

clearvars -except lambda
%% END of the algorithm
end

