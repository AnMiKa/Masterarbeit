function err = final_class_error(lambda,Xt,Yt,Xv,Yv)

[feat,~] = size(Xt);

%Wb = postpro_wb_class_hinge_qpas(X,Y,lambda);
Wb = postpro_wb_class_hingequad_qp(Xt,Yt,lambda);
w = Wb(1:feat);
b = Wb(end);

%err = postpro_err_misclass(w,b,Xv,Yv);
err = postpro_err_hinge(w,b,Xv,Yv);
end