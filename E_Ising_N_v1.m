clear all

strt=tic;
%% ========================================================
% PARAMETERS
%% ========================================================

N_list = 3:1:15;

J = 1;
hz = 1;

lambda = 1;
lbda=lambda;
dt = 0.01;
T = 0:dt:2;

periodic = 1;   % 0 = OBC, 1 = PBC


%% STORAGE

Emax = zeros(size(N_list));
Pmax = zeros(size(N_list));


%% ========================================================
% LOOP SYSTEM SIZE
%% ========================================================
% figure
for nn = 1:length(N_list)

    N = N_list(nn);

    fprintf('\n=============================\n')
    fprintf('Running N = %d\n',N)
    fprintf('=============================\n')


    %% ----------------------------------------------------
    % Construct Hamiltonian
    %% ----------------------------------------------------

    [Hxx,Hyy,Hzz,Hx,Hz] = buildHamiltonian(N,J,hz,periodic);


    %% Battery Hamiltonian

    HB = hz*Hz;


    %% Charger Hamiltonian

    HC = J*Hxx;


    %% Total Hamiltonian

    H = HC + (1-lambda)*HB;


    H = sparse(H);



    %% ----------------------------------------------------
    % Initial state
    %% ----------------------------------------------------

    [V,D]=eigs(HB,1,'smallestreal');

    psi0 = V;

    psi = psi0;


    %% Initial battery energy

    E0 = real(psi0'*(HB*psi0));



    %% STORAGE ARRAYS

    Energy = zeros(length(T),1);
    Power  = zeros(length(T),1);



    %% ----------------------------------------------------
    % Krylov evolution
    %% ----------------------------------------------------

    for tt = 1:length(T)


        t=T(tt);


        if tt==1

            psi = psi0;

        else

            % Krylov exponential propagation

            psi = expmv(-1i*dt*H,psi);

        end



        % normalize

        psi = psi/norm(psi);



        %% Storage energy

        Et = real(psi'*(HB*psi));


        Energy(tt)=Et-E0;



        %% Power

        if t>0

            Power(tt)=Energy(tt)/t;

        else

            Power(tt)=0;

        end


  fprintf(sprintf(" Done till gi =%d in time %.2f J=%.1f lbda=%.1f,N=%d \n",i,toc(strt),J,lbda,N));

    end



    %% Maximum values

    Emax(nn)=max(Energy);

    Pmax(nn)=max(Power);



    fprintf('N=%d  Emax=%f  Pmax=%f\n',...
        N,Emax(nn),Pmax(nn))



    

    Energy_all{nn}=Energy;
    Power_all{nn}=Power;



    fname=sprintf('QB_Hxx_Hz_N=%d_J=%.1f_hz=%d_p=%d_lbda=%.1f.mat',N,J,hz,periodic,lambda);
    folder=['C:\Users\rohit\Documents\MATLAB\QB_charging_lambda\data\'];
    save([folder fname]) 
   
end

figure;
hold on;

for nn = 1:length(N_list)
    plot(T, Energy_all{nn}, 'o-', 'LineWidth', 2);
end
xlabel('$N$','Interpreter','latex')

ylabel('$\Delta E$',...
    'Interpreter','latex')

set(gca,'FontSize',25)

box on


%% ========================================================
% PLOTS
%% ========================================================


figure

plot(N_list,Emax,'o-','LineWidth',2)

xlabel('$N$','Interpreter','latex')

ylabel('$\Delta E_{\rm max}$',...
    'Interpreter','latex')

set(gca,'FontSize',25)

box on



figure

plot(N_list,Pmax,'o-','LineWidth',2)

xlabel('$N$','Interpreter','latex')

ylabel('$P_{\rm max}$',...
    'Interpreter','latex')

set(gca,'FontSize',25)

box on




%% ========================================================
% HAMILTONIAN FUNCTION
%% ========================================================


function [Hxx,Hyy,Hzz,Hx,Hz]=buildHamiltonian(N,J,hz,periodic)



dim=2^N;


sx=[0 1;1 0];
sy=[0 -1i;1i 0];
sz=[1 0;0 -1];

I=eye(2);



Hxx=sparse(dim,dim);
Hyy=sparse(dim,dim);
Hzz=sparse(dim,dim);

Hx=sparse(dim,dim);
Hz=sparse(dim,dim);



%% one body terms

for i=1:N


    Hx = Hx + kronN_operator(sx,i,N);

    Hz = Hz + kronN_operator(sz,i,N);


end



%% two body interaction


for i=1:N-1


    Hxx = Hxx + kronN_two(sx,i,sx,i+1,N);

    Hyy = Hyy + kronN_two(sy,i,sy,i+1,N);

    Hzz = Hzz + kronN_two(sz,i,sz,i+1,N);


end



%% periodic boundary

if periodic==1

    Hxx = Hxx + kronN_two(sx,N,sx,1,N);

    Hyy = Hyy + kronN_two(sy,N,sy,1,N);

    Hzz = Hzz + kronN_two(sz,N,sz,1,N);

end


end




%% ========================================================
% SINGLE SITE OPERATOR
%% ========================================================

function A=kronN_operator(op,pos,N)


A=1;

for k=1:N

    if k==pos

        A=kron(A,op);

    else

        A=kron(A,eye(2));

    end

end


A=sparse(A);

end



%% ========================================================
% TWO SITE OPERATOR
%% ========================================================

function A=kronN_two(op1,pos1,op2,pos2,N)


A=1;


for k=1:N


    if k==pos1

        A=kron(A,op1);


    elseif k==pos2

        A=kron(A,op2);


    else

        A=kron(A,eye(2));


    end


end


A=sparse(A);


end