function [AdjustedImage] = selfquotientimage(InputImage, n)

ROW = size(InputImage,1);
COL = size(InputImage,2);

B = zeros(ROW+2*n, COL+2*n);

B(n+1:ROW+n, n+1:COL+n) = double(InputImage);

A = double(B);

for i=n+1:ROW+n
    for j=n+1:COL+n
        B(i,j) = A(i,j)/max(mean(mean(A(i-n:i+n, j-n:j+n))), 1);
    end
end


AdjustedImage = round(255*(B - min(B(:)))/(max(B(:)) - min(B(:))));

AdjustedImage = AdjustedImage(n+1:ROW+n, n+1:COL+n);


