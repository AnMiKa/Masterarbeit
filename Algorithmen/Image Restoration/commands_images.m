load f_new_25;
load g_new;
F_NOISE = f_noise(:,idx);
G_TRUTH = g_truth(:,idx);
F_pic = reshape(F_NOISE,64,64);
G_pic = reshape(G_TRUTH,64,64);
figure
imagesc(F_pic);
figure
imagesc(G_pic);
colormap(gray(256));