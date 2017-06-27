function err = final_class_error_hingequad(lambda,Xt,Yt,Xv,Yv)

[feat,J,T] = size(Xt);

Xt = reshape(Xt,[feat,J*T]);
Yt = reshape(Yt,[J*T,1]);
%Wb = postpro_wb_class_hinge_qpas(X,Y,lambda);
%Wb = postpro_wb_class_hingequad_qp(Xt,Yt,T*lambda/(T-1));
Wb = postpro_wb_class_hingequad_qp(Xt,Yt,lambda);
w = Wb(1:feat);
b = Wb(end);

err = 100*postpro_err_hingequad(w,b,Xv,Yv);
end