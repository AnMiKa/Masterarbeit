% plotting script upper level objective 2-group synsmall

% grid of input values
C = linspace(1e-6,0.03,50);
[C1,C2] = meshgrid(C,C);
[a,b] = size(C1);
err = zeros(a,b);
for i = 1:numel(C1)
    W = solve_ll_and_subgr([C1(i);C2(i)],Xtiong_2,Ytiong_2);
    err(i) = ul_obj_class_hingequad(Xtiong_2,Ytiong_2,W);
end

figure
surfc(C1,C2,err)
colormap('cool')