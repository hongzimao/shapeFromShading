function  newSurfaceNormal = graphCutSurfaceNormal(surfaceNormal)
tic;

lambda = 0.01;
sigma = 1;
epsilon = 0.01;

[W, H, ~] = size(surfaceNormal);
Icosahedron = icosahedron(0.1);
[sIco, ~] = size(Icosahedron);

NormalLabel = zeros(W, H);
for i = 1:W
    for j = 1:H
        d = (Icosahedron(:,1)-surfaceNormal(i,j,1)).^2 + ...
            (Icosahedron(:,2)-surfaceNormal(i,j,2)).^2 + ...
            (Icosahedron(:,3)-surfaceNormal(i,j,3)).^2;
        [~, index] = min(d);
        NormalLabel(i, j) = index;
    end
end

WH = W*H;
segclass = reshape(NormalLabel, 1, [])';  % initial Normal
pairwise = sparse(WH,WH);                 % neighborhood term 
unary = zeros(sIco,WH);                   % cost connect to each label
labelcost = zeros(sIco, sIco);            % smoothness term

for row = 0:H-1
  for col = 0:W-1
    pixel = 1+ row*W + col;
    if row+1 < H 
        Na = segclass(pixel);
        Nb = segclass(1+col+(row+1)*W);
        ico = Icosahedron(Na, :) - Icosahedron(Nb, :);
        ico = sqrt(ico*ico');
        pairwise(pixel, 1+col+(row+1)*W) = lambda * log(1 + ico/sigma);
    end
    
    if row-1 >= 0 
        Na = segclass(pixel);
        Nb = segclass(1+col+(row-1)*W);
        ico = Icosahedron(Na, :) - Icosahedron(Nb, :);
        ico = sqrt(ico*ico');
        pairwise(pixel, 1+col+(row-1)*W) = lambda * log(1 + ico/sigma); 
    end
    
    if col+1 < W 
        Na = segclass(pixel);
        Nb = segclass(1+(col+1)+row*W);
        ico = Icosahedron(Na, :) - Icosahedron(Nb, :);
        ico = sqrt(ico*ico');
        pairwise(pixel, 1+(col+1)+row*W) = lambda * log(1 + ico/sigma); 
    end
    
    if col-1 >= 0 
        Na = segclass(pixel);
        Nb = segclass(1+(col-1)+row*W);
        ico = Icosahedron(Na, :) - Icosahedron(Nb, :);
        ico = sqrt(ico*ico');
        pairwise(pixel, 1+(col-1)+row*W) = lambda * log(1 + ico/sigma); 
    end 
    
    for i = 1:sIco
        ico = Icosahedron(i, :) - Icosahedron(segclass(pixel)+1, :);
        unary(i,pixel) = sqrt(ico*ico');
    end
  end
end

for i = 1:sIco
    for j = 1:sIco
        Sij = Icosahedron(i, :) - Icosahedron(j, :);
        Sij = sqrt(Sij*Sij');
        K = 1 + epsilon - exp(-(2-Sij)/sigma^2);
        labelcost(i, j) = lambda*K*Sij;
    end
end


toc;

tic;
segclass = segclass - 1;
[labels, ~, ~] = GCMex(segclass, single(unary), pairwise, single(labelcost), 1);
labels = labels + 1;
toc;

labels = reshape(labels, W, H);
newSurfaceNormal = zeros(W, H, 3);

for i = 1:W
    for j = 1:H
        newSurfaceNormal(i, j, :) = Icosahedron(labels(i,j), :);
    end
end

end