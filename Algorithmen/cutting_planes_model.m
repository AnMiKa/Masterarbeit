function [ y ] = cutting_planes_model( x, f_bundle, g_bundle, x_bundle )
%CUTTING_PLANES_MODEL cutting planes model with resepct do the current
%stability center

n = length(f_bundle);
X = bsxfun(@minus, x, x_bundle);
G = zeros(1,n);
for i = 1:n
    G(i) = g_bundle(:,i)'*X(:,i);
end
y = max(f_bundle+G);

end

