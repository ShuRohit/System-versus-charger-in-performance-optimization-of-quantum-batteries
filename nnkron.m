%% author: Gautam Naik
% requires: 
% input: 1: number of times to tensor
%        2: matrix to tensor
% output: kron (tensor product) of matrix 'a', 'n' times
%%  
function y= nnkron(n,a)
    y=a;
    for i=1:(n-1)
       y= kron(y,a);
    end
end
