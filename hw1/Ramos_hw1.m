aVec = 5:-0.1:-5; % creates 1x101 vector containing all the values from 5 to -5 in steps of -0.1

aMat = ones(4) * 5; % creates 4x4 matrix with all 5's

bMat = diag([1 3 5 3 1]) % creates 5x5 matrix with the values 1 3 5 3 1 on the diagonal

cMat = reshape(1:49, [7,7]) % 7x7 matrix containing 1-49

eMat = cMat(:, [5, 6]) % 7x2 matrix containing columns 5 and 6 of cMat

fMat = randi([21, 26], 6, 1) % 6x1 column vector containing random ints from 21-26

cSum = sum(cMat, 1) % column-wise sum of cMat

cMean = mean(cMat, 2) % mean of all rows of cMat

cSub = cMat([3 4 5], [3 4 5]) % submatrix of cMat that contains rows 3 to 5 and columns 3 to 5

cSqrt = sqrt(cMat) % Matrix that contains the square root of every element of cMat

rMat = repmat([1 2 3; 4 5 6; 7 8 9], 6, 9) % 6x9 matrix with the matrix [1 2 3; 4 5 6; 7 8 9] tiled within it 