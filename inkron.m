%% author: Gautam Naik
% requires: 
% input: 1: total number of spins 1/2s in the chain
%        2: the position of operation
%        3: operator to operate at 'i'
% output: kron (tensor porduct) of Identity with operator so that operator
%        acts only at position 'i'.
%%  
function y = inkron(n,i,a)
    I=eye(2);
    if i==1
        y=a;
    else 
        y=I;
    end
   
        
    for k=2:(n)
        if k==i
           y= kron(y,a);
        else
           y= kron(y,I);
        end
    end
end
    
    
