%%
%author: Rohit
% requires: inkron
% input: 1: N , periodic , spin_matrix (set 1 to use Spin matrices instead of sigma matrices) 
%        2: H_str -specify the Hamilotnian of (Hx Hxx Hy Hyy Hz Hzz) with
%           coefficients.
% output: H=eval(H_str) 

%%
sigz=1*[1,0;0,-1];
sigx=1*[0,1;1,0];
sigy=1*[0,-1j;1j,0];

if exist('spin_matrix','var')==0
    spin_matrix=0;
end

if spin_matrix==1
    sx=sigx/2;
    sy=sigy/2;
    sz=sigz/2;
    
    SZ=@(i) sparse(inkron(N,i,sz));
    SX=@(i) sparse(inkron(N,i,sx));
    SY=@(i) sparse(inkron(N,i,sy));

elseif spin_matrix==0
    SZ=@(i) sparse(inkron(N,i,sigz));
    SX=@(i) sparse(inkron(N,i,sigx));
    SY=@(i) sparse(inkron(N,i,sigy));
else
    errormsg('spin_matrix should take value of either 1 or 0.')'
end
if contains(H_str,"Hxx")
        Hxx=0;
        for k=1:N-1
            Hxx=Hxx+(SX(k)*SX(k+1));
        end
        if periodic==1
            Hxx=Hxx+(SX(N)*SX(1));            %%%%%%%%%%%%%%%
        end
    end
    
    if contains(H_str,"Hzz")
        Hzz=0;
        for k=1:N-1
            Hzz=Hzz+(SZ(k)*SZ(k+1));
        end
        if periodic==1
            Hzz=Hzz+(SZ(N)*SZ(1));            %%%%%%%%%%%%%%%
        end
    end
    if contains(H_str,"Hyy")
        Hyy=0;
        for k=1:N-1
            Hyy=Hyy+(SY(k)*SY(k+1));
        end
        if periodic==1
            Hyy=Hyy+(SY(N)*SY(1));            %%%%%%%%%%%%%%%
        end    
    end
    if ~isempty(setdiff(strfind(H_str,"Hz"),strfind(H_str,"Hzz")))
        Hz=0;
        for k=1:N
            Hz=Hz+SZ(k);
        end
    end
    
    if ~isempty(setdiff(strfind(H_str,"Hx"),strfind(H_str,"Hxx")))
        Hx=0;
        for k=1:N
            Hx=Hx+SX(k);
        end
    end
    
    if ~isempty(setdiff(strfind(H_str,"Hy"),strfind(H_str,"Hyy")))
        Hy=0;
        for k=1:N
            Hy=Hy+SY(k);
        end
    end
if contains(H_str,"Hxx_all")
    Hxx_all = 0;
    for i = 1:N-1
        for j = i+1:N
            Hxx_all = Hxx_all + (SX(i) * SX(j));
        end
    end
end

if contains(H_str,"Hzz_all")
    Hzz_all = 0;
    for i = 1:N-1
        for j = i+1:N
            Hzz_all = Hzz_all + (SZ(i) * SZ(j));
        end
    end
end

if contains(H_str,"Hyy_all")
    Hyy_all = 0;
    for i = 1:N-1
        for j = i+1:N
            Hyy_all = Hyy_all + (SY(i) * SY(j));
        end
    end
end

if contains(H_str,"Hxxx_all")
    Hxxx_all = 0;
    for i = 1:N-2
        for j = i+1:N-1
            for k = j+1:N
                Hxxx_all = Hxxx_all + (SX(i) * SX(j) * SX(k));
            end
        end
    end
end

H = eval(H_str);