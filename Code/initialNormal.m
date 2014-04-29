function surfaceNormal = initialNormal(x, y, z)
[imgIntensity, lights, denominatorLight] = preProcessData(x, y, z); % imgIntensity here alread divide Denominator image
[M, N, s] = size(imgIntensity);
matrixToFindNormal = zeros(s, 3);
surfaceNormal = zeros(M, N, 3);
tic;
for i = 1:M
    for j = 1:N
        for k = 1:s
           matrixToFindNormal(k, :) = [lights(k,1)-imgIntensity(i,j,k)*denominatorLight(1),...
                                        lights(k,2)-imgIntensity(i,j,k)*denominatorLight(2),...
                                         lights(k,3)-imgIntensity(i,j,k)*denominatorLight(3)];
        end
        [~,~,v]=svd(matrixToFindNormal);
        temp = v(:,end);
        if temp(3)<0
            temp = -temp;
        end
        surfaceNormal(i,j,:)=temp;
    end
end
toc;
end