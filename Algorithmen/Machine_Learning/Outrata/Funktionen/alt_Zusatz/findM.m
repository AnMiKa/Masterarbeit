function [ Ip, M ] = findM( X, Acalc, Mult, Xi, tol )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin == 4
    tol = 1e-15;
end

[feat,J,T,G] = size(X);

M = zeros(J,T);
Ip = zeros(J,T);


for t = 1:T
    % find the weakly active constraints
    % these are the ones that are active and have a zero multiplier
    acalci = find(abs(Acalc(:,t)) < 10*tol);
    multi = find(Mult(:,t) < 10*tol);
    weakac = intersect(acalci,multi);
    strac = setdiff(acalci,multi);
    Ip(1:length(strac),t) = strac;
    % if no weakly active constraints, then M is empty
    % pass on and check for the next fold
    if isempty(weakac)
        continue
    end
    % if there are weakly active constraints first check if corollary holds
    JCH = zeros(G,feat+J*max(1,(T-1)));
    for g = 1:G
        JCH(g,feat+(g-1)*J*max(1,(T-1))+1:feat+g*J*max(1,(T-1))) = ...
            Xi((g-1)*J*max(1,(T-1))+1:feat+g*J*max(1,(T-1)),t);
    end
    kerJCH  = null(JCH);
    cond = find(sum(Acalc(Mult(:,t) >= 10*tol,t)*kerJCH,1)> 1e-12);
    if sum(cond) == T
        % which bound???
        continue
        % what do I do if for all M possible? At the moment empty M
    end
    % if corollary does not hold check theorem for all possible M
    % can use combnk to create power set but only if weakly active indices
    % are not too many (about 10)
    error('Subgradient of bilevel program cannot be calculated due to M fulfilling not all conditions')
    % break and end all with some message that calculation of the 
    % subgradient is not possible if theorem does not hold
end

end

