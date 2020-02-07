% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
images = loadMNISTImages('train-images-idx3-ubyte');
labels = loadMNISTLabels('train-labels-idx1-ubyte');

% We are using display_network from the autoencoder code
display_network(images(:,1:100)); % Show the first 100 images
disp(labels(1:10));

%We need to write something which changes the label value "5", etc. to the
%correct vector. Then, we will make a B matrix out of this. 
B = zeros (10, 0);
{
for i = 1:60000 
    x = labels (i, 1);
    y = zeros(10,1);
    if x == 0
        y (10, 1) = 1;
        B = [B y];
    else
        y (x, 1) = 1;
        B = [B y];
    end
end 


%We have to transpose A and B to make the dimensions of Ax = B make sense. 
B_better = B.';
A_better = images.';

%Implementing lasso
X = zeros (784, 10);
for i = 1:10
    X(:, i) = lasso (A_better, B_better(:, i), 'Lambda', 0.01);
end 

%Implementing ridge 
X = zeros (784, 10);
for i = 1:10
    X(:, i) = ridge (B_better(:,i), A_better, 0.01);
end 

%Implementing pinv 
X = zeros (784, 10);
A_inverse = pinv(A_better);
X = A_inverse*B_better;


j = 10;
H = reshape (X(:, j), 28, 28);
pcolor(H);
title (0);

display_network(X(:, 1:10));

output_image (1, images);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This section uses the test data. 

test_images = loadMNISTImages('t10k-images-idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels-idx1-ubyte');

%This takes the test images and multiplies the matrix X that we found with
%the training data to see if the result matches the labels
Y = test_images.';
Result = Y*X;

%This function returns the largest value of Result from each row and puts
%the value into M, while putting which column this largest value was in
%into . 
[M,label_results] = max(Result,[],2);
%The 10th column is actually meant for 0. 
for i = 1:10000
    if label_results(i, 1) == 10
        label_results (i, 1) = 0;
    end
end

%Put these two into the same matrix.
Match = zeros(10000, 2);
Match (:,1) = label_results;
Match (:,2) = test_labels;

%Let's see how many equal each other.
h = 0;
for i =1:10000
    if Match (i, 1) == Match (i, 2)
        h = h + 1;
    end
end

%It looks like we predicted the images accurately 78.35% of the time. 



%This takes the images matrix and looks at just the first coumn, 
%makes it a square matrix, and then displays it as a colored image.
%It actually displays it upside down for some reason?
function f = output_image (i, images)
    M = images (:,i);
    M = M.';
    M_square = reshape (M, 28, 28);
    pcolor (M_square);
end 