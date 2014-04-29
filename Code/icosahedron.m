function output = icosahedron(subdivider) % subdivide surface of icosahedron, smaller -> finer
t = (1+sqrt(5))/2; %golden ratio
a = sqrt(t)/5^(1/4);
b = 1/(sqrt(t)*5^(1/4));
c = a+2*b;
d = a+b;
x =  [0;0;0;0;b;-b;b;-b;a;a;-a;-a]; % vertices of icosaherdron
y =  [a;a;-a;-a;0;0;0;0;b;-b;b;-b];
z =  [b;-b;b;-b;a;a;-a;-a;0;0;0;0];
mx = [d;d;d;d;-d;-d;-d;-d;0;0;0;0;c;-c;c;-c;a;a;-a;-a]/3; % midpoint extension
my = [d;-d;d;-d;d;-d;d;-d;a;a;-a;-a;0;0;0;0;c;-c;c;-c]/3;
mz = [d;d;-d;-d;d;d;-d;-d;c;-c;c;-c;a;a;-a;-a;0;0;0;0]/3;

%subdivider = 0.2;  % subdivide surface of icosahedron, smaller -> finer
result = [];
for m = 1:20
    d = (x-mx(m)).^2 + (y-my(m)).^2 + (z-mz(m)).^2;
    [~, order] = sort(d);
    p1 = [mx(m), my(m), mz(m)];
    p2 = [x(order(1)), y(order(1)), z(order(1))];
    p3 = [x(order(2)), y(order(2)), z(order(2))];
    result = [result; subdivide(p1, p2, p3, subdivider)];
    
    p3 = [x(order(3)), y(order(3)), z(order(3))];
    result = [result; subdivide(p1, p2, p3, subdivider)];
    
    p2 = [x(order(2)), y(order(2)), z(order(2))];
    result = [result; subdivide(p1, p2, p3, subdivider)];
    
    diagnoal = sqrt(diag((result*result')));
    result(:,1) = result(:,1)./diagnoal;
    result(:,2) = result(:,2)./diagnoal;
    result(:,3) = result(:,3)./diagnoal;
end

% half plane
s = size(result, 1);
output = [];
for i = 1:s
   if result(i,3)>=0
       output = [output; result(i,:)];
   end
end
%output = unique(output,'rows');
%scatter3(output(:,1), output(:,2), output(:,3));
end