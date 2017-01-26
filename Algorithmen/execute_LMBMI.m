
x0 = ones(5,1);
fun = @f1_testfunction;
subgr_fun = @subgr_f1_testfunction;


[f_hat, x_hat, delta] = limited_memory_nonconv_inex(x0, fun, subgr_fun);