function [ lambda ] = opt_lambdas( s, s_hat, S, d, c_prev, c, C, U1, U2, R,...
    CC, UU, phi, step )
%OPT_LAMBDAS solves the lambda-subproblem of the variable metric bundle
%method
%   minizes the function
%   phi(l1,l2,l3) = (la*s_hat+l2*s+l3*S)'*D*(la*s_hat+l2*s+l3*S)+2*(l2*c+l3*C)
%   s.t. l1, l2, l3 >= 0, l1+l2+l3 = 1
%   Function is invoked in every null step to do the aggregation.
%   Implemented after the ideas in "Globally convergent variable metric
%   method nonconvex nondifferentiable unconstrained minimization" by J.
%   Vlcek and L- Luksan.

% input parameter
%
%

% output parameter
%   lambda = [lambda1, lambda2, lambda3]

% some precalculations
s_hatS = s_hat - S;
sS = s - S;
ss_hat = s-s_hat;
R_inv = inv(R);
DA = R_inv'*(CC+phi*UU)*R_inv;

Ds1 = phi^2*(s_hatS'*sS) + s_hatS'*U1*DA*U1'*sS + s_hatS'*U1*(-R_inv)'...
    *phi*U2'*sS + s_hatS'*U2*(-R_inv)*phi*U2'*sS;
Ds2 = phi^2*(s_hatS'*s_hatS) + s_hatS'*U1*DA*U1'*s_hatS + s_hatS'*U1*(-R_inv)'...
    *phi*U2'*(s_hatS) + s_hatS'*U2*(-R_inv)*phi*U2'*s_hatS;

% test if minimum is within the given bounds
% if yes -> unconstrained optimization by one Newton-step
% if no  -> check minima on the edges of the feasible set
if step == 1
    if (C*Ds1) == ((c_prev-c)*Ds2)
        SS = [s_hat, s, S];
        r = [0 c C];
        v = [U1'; phi*U2']*SS;
        SDS = v'*[DA, -R_inv'; -R_inv, zeros(length(R))]*v;
        SDS_inv = inv(SDS);
        lambda = -SDS_inv*r';
    else
        Ds3 = phi^2*(sS'*sS) + sS'*U1*DA*U1'*sS + sS'*U1*(-R_inv)'...
            *phi*U2'*sS + sS'*U2*(-R_inv)*phi*U2'*sS;
        Ds4 = phi^2*(ss_hat'*ss_hat) + ss_hat'*U1*DA*U1'*ss_hat + ss_hat'*U1*(-R_inv)'...
            *phi*U2'*ss_hat + ss_hat'*U2*(-R_inv)*phi*U2'*ss_hat;
        if norm(s_hatS) > 1e-5
            l1 = min(1,max(0,(d'*s_hatS+C)/Ds2));
        elseif C < 0
            l1 = 0;
        else
            l1 = 1;
        end
        if norm(ss_hat) > 1e-5
            l2 = min(1,max(0,(d'*ss_hat+C-c)/Ds4));
            d_hat = -
            l2_2 = min(1,max(0,(d_hat'*sshat-c)/Ds4));
        elseif C < c
            l2 = 0;
        else
            l2 = 1;
        end
        if norm(ss_hat)
        elseif c >= 0
            l2_2 = 0;
        else 
            l2_2 = 1;
        end
        
        [~,i] = min(phi1,phi2,phi2_2);
        if i == 1
            l2 = 0;
            l3 = 1-l1;
        elseif i== 2
            l1 = 0;
            l3 = 1-l2;
        else
            l1 = 1-l2_2;
            l2 = l2_2;
            l3 = 0;
        end
        lambda = [l1, l2, l3];
    end
else
    
end
clearvars -except lambda
end

