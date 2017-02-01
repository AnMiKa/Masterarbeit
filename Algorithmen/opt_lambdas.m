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

if k == 1
    SDS3 = sum(sS.^2);
else
    r = [C c-C]';
    DS1 = Dv(s_hatS, U1, U2, R, UU, CC, phi, step, i_C,rho);
    SDS1 = s_hatS'*DS1;
    DS2 = Dv(sS, U1, U2, R, UU, CC, phi, step, i_C,rho);
    SDS2 = s_hatS'*DS2;
    SDS3 = sS'*DS2;
    SDS = [SDS1 SDS2; SDS2 SDS3];
end
% test if minimum is within the given bounds
% if yes -> unconstrained optimization by one Newton-step
% if no  -> check minima on the edges of the feasible set

if step == 1
    l1 = 0;
    if norm(sS) < 1e-15
       if C < c
           l2 = 0;
       else
           l2 = 1;
       end
    else
       l2 = min(1,max(0,(d'*sS+C-c)/SDS3));
    end
    l3 = 1-l2;
    lambda = [l1,l2,l3];
else
    if rank(SDS) == 2
        lambda = -SDS\r;
        if (sum(lambda >= 0) == 2) && ((sum(lambda)-1)<1e-15)
            lambda = [lambda; 1-sum(lambda)];
        else
            l1 = min(1,max(0,(d'*s_hatS+C)/SDS1));
            l2 = min(1,max(0,(d'*sS+C-c)/SDS3));
            d_hat = -Dv(s_hat, U1, U2, R, UU, CC, phi, step, i_C,rho);
            l2_2 = min(1,max(0,(d_hat'*ss_hat-c)/SDS3));
        end    
    else
        if C < 0
            l1 = 0;
        else
            l1 = 1;
        end
        if C < c
            l2 = 0;
        else
            l2 = 1;
        end
        if c > 0
            l2_2 = 0;
        else 
            l2_2 = 1;
        end 
    end
    lambda1 = [l1, 0, 1-l1]';
    lambda2 = [0, l2, 1-l2]';
    lambda3 = [1-l2_2, l2_2, 0]';
    r = [0 c C]';
    SS = [s_hat s S];
    DS = Dv(SS,U1,U2,R,UU,CC,phi,step,i_C,rho);
    SDS = SS'*DS;
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

clearvars -except lambda
%% END of the algorithm
end

