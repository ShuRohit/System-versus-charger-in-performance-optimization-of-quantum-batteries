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
    if contains(H_str,"Hxx2")
        Hxx2=0;
        for k=1:N-2
            Hxx2=Hxx2+(SX(k)*SX(k+2));
        end
        if periodic==1
            Hxx2=Hxx2+(SX(N-1)*SX(1)); 
            Hxx2=Hxx2+(SX(N)*SX(2));
        end
    end
if contains(H_str,"Hxx3")
        Hxx3=0;
        for k=1:N-3
            Hxx3=Hxx3+(SX(k)*SX(k+3));
        end
        if periodic==1
            for k=N-2:N
            Hxx3=Hxx3+(SX(k)*SX(k+3-N)); 
            end
        end
end

if contains(H_str,"Hxx4")
        Hxx4=0;
        for k=1:N-4
            Hxx4=Hxx4+(SX(k)*SX(k+4));
        end
        if periodic==1
            for k=N-3:N
            Hxx4=Hxx4+(SX(k)*SX(k+4-N)); 
            end
        end
 end
if contains(H_str,"Hxx5")
        Hxx5=0;
        for k=1:N-5
            Hxx5=Hxx5+(SX(k)*SX(k+5));
        end
        if periodic==1
            for k=N-4:N
            Hxx5=Hxx5+(SX(k)*SX(k+5-N)); 
            end
        end
    end
if contains(H_str,"Hxx6")
        Hxx6=0;
        for k=1:N-6
            Hxx6=Hxx6+(SX(k)*SX(k+6));
        end
        if periodic==1
            for k=N-5:N
            Hxx6=Hxx6+(SX(k)*SX(k+6-N)); 
            end
        end
end
%%
if contains(H_str,"Hyy2")
        Hyy2=0;
        for k=1:N-2
            Hyy2=Hyy2+(SY(k)*SY(k+2));
        end
        if periodic==1
            Hyy2=Hyy2+(SY(N-1)*SY(1)); 
            Hyy2=Hyy2+(SY(N)*SY(2));
        end
    end
if contains(H_str,"Hyy3")
        Hyy3=0;
        for k=1:N-3
            Hyy3=Hyy3+(SY(k)*SY(k+3));
        end
        if periodic==1
            for k=N-2:N
            Hyy3=Hyy3+(SY(k)*SY(k+3-N)); 
            end
        end
end

if contains(H_str,"Hyy4")
        Hyy4=0;
        for k=1:N-4
            Hyy4=Hyy4+(SY(k)*SY(k+4));
        end
        if periodic==1
            for k=N-3:N
            Hyy4=Hyy4+(SY(k)*SY(k+4-N)); 
            end
        end
 end
if contains(H_str,"Hyy5")
        Hyy5=0;
        for k=1:N-5
            Hyy5=Hyy5+(SY(k)*SY(k+5));
        end
        if periodic==1
            for k=N-4:N
            Hyy5=Hyy5+(SY(k)*SY(k+5-N)); 
            end
        end
    end
if contains(H_str,"Hyy6")
        Hyy6=0;
        for k=1:N-6
            Hyy6=Hyy6+(SY(k)*SY(k+6));
        end
        if periodic==1
            for k=N-5:N
            Hyy6=Hyy6+(SY(k)*SY(k+6-N)); 
            end
        end
    end
%%

    if contains(H_str,"Hzz2")
        Hzz2=0;
        for k=1:N-2
            Hzz2=Hzz2+(SZ(k)*SZ(k+2));
        end
        
    end
     if contains(H_str,"H3z")
        H3z=0;
        for k=1:N-2
            H3z=H3z+(SZ(k)*SZ(k+1)*SZ(k+2));
        end
    end
 if contains(H_str,"H4z")
        H4z=0;
        for k=1:N-3
            H4z=H4z+(SZ(k)*SZ(k+1)*SZ(k+2)*SZ(k+3));
        end
 end
 if contains(H_str,"H5z")
        H5z=0;
        for k=1:N-4
            H5z=H5z+(SZ(k)*SZ(k+1)*SZ(k+2)*SZ(k+3)*SZ(k+4));
        end
 end
 if contains(H_str,"H6z")
        H6z=0;
        for k=1:N-5
            H6z=H6z+(SZ(k)*SZ(k+1)*SZ(k+2)*SZ(k+3)*SZ(k+4)*SZ(k+5));
        end
 end
 if contains(H_str,"H7z")
        H7z=0;
        for k=1:N-6
            H7z=H7z+(SZ(k)*SZ(k+1)*SZ(k+2)*SZ(k+3)*SZ(k+4)*SZ(k+5)*SZ(k+6));
        end
 end
 if contains(H_str,"H8z")
        H8z=0;
        for k=1:N-7
            H8z=H8z+(SZ(k)*SZ(k+1)*SZ(k+2)*SZ(k+3)*SZ(k+4)*SZ(k+5)*SZ(k+6)*SZ(k+7));
        end
 end


 %%%%%%%%%%%%%%%%%%%%%
 
     if contains(H_str,"H3x")
        H3x=0;
        for k=1:N-2
            H3x=H3x+(SX(k)*SX(k+1)*SX(k+2));
        end
    end
 if contains(H_str,"H4x")
        H4x=0;
        for k=1:N-3
            H4x=H4x+(SX(k)*SX(k+1)*SX(k+2)*SX(k+3));
        end
 end
 if contains(H_str,"H5x")
        H5x=0;
        for k=1:N-4
            H5x=H5x+(SX(k)*SX(k+1)*SX(k+2)*SX(k+3)*SX(k+4));
        end
 end
 if contains(H_str,"H6x")
        H6x=0;
        for k=1:N-5
            H6x=H6x+(SX(k)*SX(k+1)*SX(k+2)*SX(k+3)*SX(k+4)*SX(k+5));
        end
 end
 if contains(H_str,"H7x")
        H7x=0;
        for k=1:N-6
            H7x=H7x+(SX(k)*SX(k+1)*SX(k+2)*SX(k+3)*SX(k+4)*SX(k+5)*SX(k+6));
        end
 end
 if contains(H_str,"H8x")
        H8x=0;
        for k=1:N-7
            H8x=H8x+(SX(k)*SX(k+1)*SX(k+2)*SX(k+3)*SX(k+4)*SX(k+5)*SX(k+6)*SX(k+7));
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

H=eval(H_str);