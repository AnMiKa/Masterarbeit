function [ d, S, U, R, C, UU, theta ] = lbfgs( s, u, g_plus, S, U,  R, C, UU, m_max, theta )
%LBFGS limited memory BFGS update for the metric matrix and direction
%finding from it
%   The Algorithm is implemented after the one in the paper "New limited
%   memory bundle method for large-scale nonsmooth optimization" by Napsu
%   Karmitsa (Haarala), Kaisa Miettinen and Marko M. Mäkelä.
%   It updates the metric matrix and calculates the search direction d for
%   their limited memory varible metric bundle method.


%% BEGINNING of the algorithm
[~,m] = size(S);

if u'*s <= 0    % cannot happen in first step
    Sg = S'*g_plus;
    Ug = U'*g_plus;
else
    m_plus = min(m+1,m_max);
    
    if m < m_max
        S = [S,s];
        U = [U,u];
    else
        S = [S(:,2:end),s];
        U = [U(:,2:end),u];
    end
    
    Sg = S'*g_plus;
    Ug = U'*g_plus;
    Su = S'*u;
    Uu = U'*u;
    
    if m < m_max
        R = [[R;zeros(1,m)],Su];
        UU = [[UU; Uu(1:end-1)'], Uu];
        C = spdiags([spdiags(C),s'*u],0,m_plus,m_plus);
    else
        R = [[R(2:end,2:end),zeros(1,m-1)],Su];
        UU = [[UU(2:end,2:end);u'*U(:,2:end)],Uu];
        C_diag = spdiags(C);
        C = spdiags([C_diag(2:end),s'*u],0,m_plus,m_plus);
    end
    
    if norm(u) > 0
        theta = u'*s/norm(u);
    else
        theta = 1;
    end
end
    
    p1 = R\Sg;
    p2 = R\(C*p1+theta*UU*p1-theta*Ug);
    d = theta*U*p1-S*p2-theta*g_plus;
%% END of the algorithm
end

