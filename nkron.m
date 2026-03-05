%% author: Gautam Naik
% requires: 
% output: kron (tensor product) of all input matrices
%%
function x = nkron(varargin)
    x=varargin{1};
    for vari=2:nargin
        x=kron(x,varargin{vari});
    end
end