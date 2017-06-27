function err = final_class_error(lambda,X,Y)

[feat,~] = size(X);

%Wb = postpro_wb_class_hinge_qpas(X,Y,lambda);
Wb = postpro_wb_class_hingequad_qp(X,Y,lambda);
w = Wb(1:feat);
b = Wb(end);

err = postpro_err_misclass(w,b,X,Y);
end