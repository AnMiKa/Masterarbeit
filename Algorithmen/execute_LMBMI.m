
x0 = ones(5,1);
fun = @f1_testfunction;
subgr_fun = @subgr_f1_testfunction;


[f_hat1, x_hat1, delta1] = limited_memory_nonconv_inex(x0, fun, subgr_fun);
[f_hat2, x_hat2, delta2] = limited_memory_bundle(x0, fun, subgr_fun);

res1 = f_hat1-f_hat2;
res2 = x_hat1-x_hat2;
res3 = delta1-delta2;