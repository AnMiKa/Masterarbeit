function [ tR, tL ] = linesearch( fun, subgr_fun, x, d, theta, epsIL, epsIR, tI, tmin, gamma, omega,...
    delta_w, imax, i_null_C )
%LINESEARCH linesearch sub-algorithm for finding the stepsize
%   The Algorithm is implemented after the one in the paper "Globally
%   convergent limited memory bundle methods for large-scale nonsmooth optimization"
%   by Napsu Karmitsa (Haarala), Kaisa Miettinen and Marko M. Mäkelä.
%   It finds a suitable step length for the limited memory varible metric bundle method.


%% BEGINNING of the algorithm

% how to find? what smart choic???
epsIA = (epsIR-epsIL)/2;
epsIT = (epsIR-epsIA+epsIL)/2;

tA = 0;
t = tI;
tU = tI;
iI = 0;
epsL = theta*epsIL;
epsR = theta*epsIR;
epsA = theta*epsIA;
epsT = theta*epsIT;

kappa = 1 - 1/(2*(1-epsT));

while 1
    input = x+t*theta*d;
    f = feval(fun,input);
    fx = feval(fun,x);
    g = feval(subgr_fun,input);
    beta = max(abs(fx-f+t*theta*d'*g),gamma*(t*theta*norm(d))^omega);

    if f <= fx-epsT*t*delta_w
        tA = t;
    else
        tU = t;
    end

    % really exclusive or???
    if (f <= fx-epsL*t*delta_w) && xor(t >= tmin, beta > epsA*delta_w)
        tR = t;
        tL = t;
        break
    elseif f > fx && i_null_C > 0 && iI < imax 
        iI = iI+1;
        if tA == 0
            t = max(kappa*tU, -1/2*tU^2*delta_w/(fx-f-tU*delta_w));
        else
            t = (tA+tU)/2;
        end
    elseif -beta+theta*d'*g >= -epsR*delta_w
        tR = t;
        tL = 0;
        break
    end
end

clearvars -except tL tR
%% END of the algorithm
end

