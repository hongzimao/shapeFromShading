function [result, index, uniqueIndex] = resamplingData(x, y, z)
subSamples = icosahedron(0.2); % subdivided icosahedron
%scatter3(subSamples(:,1), subSamples(:,2), subSamples(:,3));
s = size(subSamples, 1);
result = [];
index = [];
for i = 1:s
    d = (x-subSamples(i, 1)).^2 + (y-subSamples(i, 2)).^2 + (z-subSamples(i, 3)).^2;
    [~, order] = sort(d);
    result = [result; [x(order(1)), y(order(1)), z(order(1))]];
    index = [index; order(1)];
end
%scatter3(result(:,1), result(:,2), result(:,3));
uniqueIndex = unique(index); %delete duplicate
end