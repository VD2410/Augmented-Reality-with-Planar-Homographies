function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points

A = zeros(2*size(x1,1), 9);
i = 1;
% disp(size(A,1))
while (i < size(A,1)/2)
    
    A(2*i-1,:) = [-x1(i,1),-x1(i,2),-1,0,0,0,x2(i,1)*x1(i,1),x2(i,1)*x1(i,2),x2(i,1)];
    A(2*i,:) = [ 0, 0, 0, -x1(i,1), -x1(i,2), -1, x2(i,2)*x1(i,1), x2(i,2)*x1(i,2), x2(i,2)];
     
    i = i+1;
end

[u,s,v] = svd(A);
 
H2to1 = v(:,9);
 
H2to1 = reshape(H2to1, [3 3]);

% [V, ~] = eig(A' * A);
% H2to1 = reshape(V(:,1), 3, 3);
% H2to1 = H2to1';

% H2to1 = H2to1./H2to1(3,3);

end
