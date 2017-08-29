function [ W, grad_ul, subgr_ul ] = solve_ll_and_subgr( C, X, Y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% General
% if nargin == 3
%     tol = 1e-15;
% end

tolll = 1e-15;
tolad = 1e-15;

[feat,J,T,G] = size(X);
% number of features is actually feat+1 because of implicit bias
W = zeros(feat,T);
subgr_ul = zeros(G,T);
grad_ul = zeros(feat,T);

% create matrix H(C)
Cvec = zeros(1,J*G*max(1,(T-1)));
for g = 1:G
    Cvec((g-1)*J*max(1,(T-1))+1:g*J*max(1,(T-1))) = C(g)*ones(J*max(1,(T-1)),1);
end
H = spdiags([ones(1,feat),Cvec]',0,feat+J*G*max(1,(T-1)),feat+J*G*max(1,(T-1)));

for t = 1:T
    % extract training data for the t'th fold
    if T == 1
        Xt = reshape(X,feat,J*G);
        Xv = Xt;
        Yt = reshape(Y,J*G,1);
        Yv = Yt;
    else
        Xt = X;
        Xt(:,:,t,:) = [];
        Xt = reshape(Xt,feat,J*G*(T-1));
        Xv = reshape(X(:,:,t,:),feat,J*G);
        Yt = Y;
        Yt(:,t,:) = [];
        Yt = reshape(Yt,J*G*(T-1),1);
        Yv = reshape(Y(:,t,:),J*G,1);
    end
    
%% Calculate solution of lower level problem    
    % create matrices for use with quadprog
    A = [sparse(-(Yt.*Xt')), -spdiags(ones(J*G*max(1,(T-1)),1),0,J*G*max(1,(T-1)),J*G*max(1,(T-1)))];
    b = (-ones(J*G*max(1,(T-1)),1));
    % solve QP with quadprog
    options = optimoptions('quadprog','MaxIterations',1000,'OptimalityTolerance',...
        tolll,'ConstraintTolerance',tolll);
    [w,~,~,~,mult] = quadprog(H,[],A,b,[],[],[],[],[],options);
    % solution and multipliers
    W(:,t) = w(1:feat);
    Xi = w(feat+1:end);
    Mult = mult.ineqlin;
    Acalc = A*w-b;
    
%% find suitable set of weakly active indices M 
    % acitve indices
    acalc0 = find(abs(Acalc) < 10*tolll);
    % multipliers = 0
    mult0 = find(Mult < 10*tolll);
    % weakly active indices
    weakac = intersect(acalc0,mult0);
    % if no weakly active constraints, then M is empty
    % pass on and check for the next fold
    if ~isempty(weakac)
        % if there are weakly active constraints first check if corollary holds
        JCHt = zeros(G,feat+J*max(1,(T-1)));
        for g = 1:G
            JCHt(g,feat+(g-1)*J*max(1,(T-1))+1:feat+g*J*max(1,(T-1))) = ...
                Xi((g-1)*J*max(1,(T-1))+1:g*J*max(1,(T-1)));
        end
        kerJCH  = null(JCHt);
        cond = find(sum(Acalc(Mult(:,t) >= 10*tolll,t)*kerJCH,1)> 1e-12);
        if abs(sum(cond)-T) > 0 % what do I do if for all M possible? At the moment empty M
            % if corollary does not hold check theorem for all possible M
            % can use combnk to create power set but only if weakly active indices
            % are not too many (about 10)
            error('Subgradient of bilevel program cannot be calculated due to M fulfilling not all conditions')
            % break and end all with some message that calculation of the 
            % subgradient is not possible if theorem does not hold   
        end             
    end
    
%% calculate gradient of upper level objective with respect to w
    delta = (1-Yv.*(Xv'*W(:,t))) > 0;
    % *100 because of scaling of the objective function
    grad_ul(:,t) = 100*2/(G*J)*sum(max(1-Yv.*(Xv'*W(:,t)),0)'.*(-(delta.*Yv)'.*Xv),2);
    
%% calculate the subgradients for the different folds 
% contains solution of adjoint program
    % create matrices for use with quadprog
    % strongly active constraints
    strac = setdiff(acalc0,mult0);
    Aeq = A([strac;weakac],:);
    [n,~] = size(Aeq);
    beq = sparse(n,1);
    h = sparse([-grad_ul(:,t);zeros(J*G*max(1,(T-1)),1)]);
    % solve QP with quadprog
    options = optimoptions('quadprog','MaxIterations',1000,'OptimalityTolerance',...
        tolad,'ConstraintTolerance',tolad);
    % solution of the adjoint problem
    p = quadprog(H,h,[],[],Aeq,beq,[],[],[],options);
    % calculation of the subgradient for the t'th fold
    if exist('JCH','var')
    else
        % compute transpose JAcobian with respect to C of lower level
        % objective
        JCHt = zeros(G,feat+J*max(1,(T-1)));
        for g = 1:G
            JCHt(g,feat+(g-1)*J*max(1,(T-1))+1:feat+g*J*max(1,(T-1))) = ...
                Xi((g-1)*J*max(1,(T-1))+1:g*J*max(1,(T-1)));
        end
    end
    subgr_ul(:,t) = -JCHt*p;
end
grad_ul = 1/T*sum(grad_ul,2);
subgr_ul = 1/T*sum(subgr_ul,2);
end