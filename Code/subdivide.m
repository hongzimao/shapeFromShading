function result = subdivide(p1, p2, p3, subdivider)
result = [];
    for i = subdivider:subdivider:1
        for j = 0:1/(1/subdivider-(1-i)/subdivider):1
            result = [result; j*(i*p1+(1-i)*p2) + (1-j)*(i*p3+(1-i)*p2)];
        end
    end
    result = [result; p2];
end