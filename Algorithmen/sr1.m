function [ d, S, U, R, C, UU, theta ] = sr1( s, u, S, U, R, C, UU, G, G_plus, d, i_null, m_max, theta)
%SR1 symmetric rank 1 update for the metric matrix and direction finding
%from it
%   The Algorithm is implemented after the one in the paper "Globally
%   convergent limited memory bundle methods for large-scale nonsmooth
%   optimization" by Napsu Karmitsa (Haarala), Kaisa Miettinen and Marko M. M�kel�.
%   It updates the metric matrix and calculates the search direction d for
%   their limited memory varible metric bundle method.

% Input parameters
%   u, s            most recent correction pair
%   m_max           maximum number of stored correction pairs
%   G_plus          current aggregate subgradient
%   G               previous aggregate subgradient
%   d               previous search direction d
%   [U,S]           2 matrices with other correction pairs
%   i_null          number of consecutive null steps
%   R
%   UU
%   C
%   theta

%% BEGINNING of the algorithm
%% 0 step: initialization

[~,m] = size(S);
theta_plus = 1;      % scaling parameter
i_up = 0;
if m == 0
    SG = [];
    UG = [];
else
    SG = S'*G_plus;
    UG = U'*G_plus;
end

if -d'*u - G'*s < 0
    m_plus = min(m+1,m_max);
    sG = s'*G_plus;
    uG = u'*G_plus;
    
    if or(i_null == 1, m_plus < m_max) % xor???
    else
        p = (theta*UU-R-R'+C)\(theta*UG-SG);
        z = theta*G_plus-(theta*U-S)*p;
        a = G_plus'*z;
        i_up = 1;
    end
    
    if m < m_max
        S_plus = [S,s];
        U_plus = [U,u];
    else
        S_plus = [S(:,2:end),s];
        U_plus = [U(:,2:end),s];
    end
    
    Su = S_plus'*u;
    Uu = U_plus'*u;
    
    if m < m_max
        R_plus = [[R;zeros(1,m)],Su];
        UU_plus = [[UU; Uu(1:end-1)'], Uu];
        C_plus = spdiags([spdiags(C)',s'*u]',0,m_plus,m_plus);
    else
        R_plus = [[R(2:end,2:end),zeros(1,m-1)],Su];
        UU_plus = [[UU(2:end,2:end);u'*U(:,2:end)],Uu];
        C_diag = spdiags(C);
        C_plus = spdiags([C_diag(2:end),s'*u],0,m_plus,m_plus);
    end
    
    SG_plus = [SG', sG]';
    UG_plus = [UG', uG]';
else
    S_plus = S;
    U_plus = U;
    R_plus = R;
    UU_plus = UU;
    C_plus = C;
    SG_plus = SG;
    UG_plus = UG;
end

p = (theta_plus*UU_plus-R_plus-R_plus'+C_plus)\(theta_plus*UG_plus-SG_plus);
d = -theta_plus*G_plus+(theta_plus*U_plus-S_plus)*p;
if i_up == 1
    b = G_plus'*d;
    if a+b < 0
        d = -z;
    end
else
    S = S_plus;
    U = U_plus;
    R = R_plus;
    C = C_plus;
    UU = UU_plus;
    theta = theta_plus;

    clearvars -except d S U R C UU theta 
%% END of the algorithm
end

