% plotting script upper level objective 2-group synsmall

% grid of input values
C = linspace(1e-3,10,50);
[C1,C2] = meshgrid(C,C(1:25));
[a,b] = size(C1);
err = zeros(a,b);
for i = 1:numel(C1)
    W = solve_ll_and_subgr([C1(i);C2(i)],Xtcang_3,Ytcang_1);
    err(i) = ul_obj_class_hingequad(Xtcang_3,Ytcang_1,W);
end

figure
surfc(C1,C2,err)
colormap('cool')