function lightImg = diffuseLight(surfaceNormal)
[m, n, ~] = size(surfaceNormal);
lightImg = zeros(m, n);
light = [-2,2,2]/sqrt(14);
normal = zeros(3,1);
for i = 1:m
    for j = 1:n
        normal(:,1) = surfaceNormal(i, j, :);
        lightImg(i, j) = light*normal;
    end
end
imshow(uint8(lightImg*160));
end