clear; clc;

strt=tic;

figure;hold
%% ================= PARAMETERS =================

L_list = 4:2:8;

J = 1;
hz = 1;

lambda = 1;

periodic = 1;




Energy_all = cell(length(L_list),1);

Emax_all = zeros(length(L_list),1);



%% ================= PAULI MATRICES =================

sx = sparse([0 1;1 0]);
sz = sparse([1 0;0 -1]);

id = speye(2);



%% ================= MAIN LOOP =================

for s = 1:length(L_list)


    N=L_list(s);
    if mod(N,2)==0
   TT=2^(N/2);
else
   TT=2^((N+1)/2);
end

    
dt = .01;
T = 0:dt:TT;

    dim=2^N;


    fprintf('\nRunning N=%d dim=%d\n',N,dim)



    %% ==========================================
    % Construct Hx and Hz
    %% ==========================================

    Hx=sparse(dim,dim);
    Hz=sparse(dim,dim);


    for i=1:N


        opx=1;
        opz=1;


        for j=1:N

            if j==i

                opx=kron(opx,sx);
                opz=kron(opz,sz);

            else

                opx=kron(opx,id);
                opz=kron(opz,id);

            end

        end


        Hx=Hx+opx;
        Hz=Hz+opz;

    end



    %% ==========================================
    % Long range Ising charger
    %
    % HC=J sum_r Hxx_r/2^(r-1)
    %% ==========================================


    Hxx=sparse(dim,dim);


    rmax=floor(N/2);



    for r=1:rmax


        Jr=1/(2^(r-1));


        for i=1:N


            j=i+r;


            if j>N

                j=j-N;

            end



            opxx=1;


            for k=1:N


                if k==i || k==j

                    opxx=kron(opxx,sx);

                else

                    opxx=kron(opxx,id);

                end

            end



            Hxx=Hxx+Jr*opxx;


        end

    end



    HC=J*Hxx;



    %% ==========================================
    % Battery Hamiltonian
    %% ==========================================

    HB=hz*Hz;



    %% ==========================================
    % Initial state |↓↓...↓>
    %% ==========================================


    psi0=zeros(dim,1);

    psi0(end)=1;



    E0=real(psi0'*HB*psi0);



    %% ==========================================
    % Total Hamiltonian
    %% ==========================================


    H=HC+(1-lambda)*HB;



    %% ==========================================
    % Time evolution
    %% ==========================================


    DeltaE=zeros(size(T));


    psi_t = psi0;

for it=1:length(T)

    if it>1
        psi_t = expmv(-1i*dt*H,psi_t);
    end

    psi_t = psi_t/norm(psi_t);

    Et = real(psi_t'*HB*psi_t);

    DeltaE(it)=Et-E0;


             fprintf(sprintf(" Done till gi =%d in time %.2f J=%.1f N=%d  \n",it,toc(strt),J,N));

end








    %% save

    Energy_all{s}=DeltaE;


    Emax_all(s)=max(DeltaE);

if mod(N,2)==0
    
    target = 2*N;
else
   
    target = N;
end
tol = 0.2*N;      % tolerance (change if needed)

[pks, locs] = findpeaks(DeltaE);

% First peak satisfying the condition
idx = find(abs(pks-target) <= tol,1,'first');

if ~isempty(idx)
    Efirst = pks(idx);
    Tfirst = T(locs(idx));
else
    Efirst = NaN;
    Tfirst = NaN;
end
  %   fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lambda,hz,periodic,max(T));
  % folder=['C:\Users\shuklar\OneDrive - Bar Ilan University\Desktop\BIU\MATLAB\QB_Charging\data\'];
  %  save([folder fname]) 

Tmax_all(s)=Tfirst;
end







toc(strt)



%% ==========================================
% Plot Delta E(t)
%% ==========================================


figure;
hold on;


for s=1:length(L_list)

    Nt = length(Energy_all{s});
    time = (0:Nt-1)*dt;

    N = L_list(s);

    if mod(N,2)==0
        % Even N
        time_scaled = time/2^(N/2);
    else
        % Odd N
        time_scaled = time/2^((N-1)/2);
    end

    plot(time_scaled,...
        Energy_all{s},...
        '-o',...
        'LineWidth',2,...
        'MarkerSize',4,...
        'DisplayName',...
        sprintf('$N=%d$',N))

end


xlabel('$t$','Interpreter','latex')

ylabel('$\Delta E(t)$','Interpreter','latex')


legend('Interpreter','latex')

set(gca,'FontSize',25)

box on



%% ==========================================
% Maximum energy
%% ==========================================


figure;


plot(L_list,...
    Emax_all,...
    '-o',...
    'LineWidth',2,...
    'MarkerSize',8)


xlabel('$N$','Interpreter','latex')

ylabel('$\Delta E_{\max}$','Interpreter','latex')


set(gca,'FontSize',25)

box on

%% ==========================================
% Time to reach maximum stored energy
%% ==========================================

figure;

plot(L_list,...
     Tmax_all,...
     '-o',...
     'LineWidth',2,...
     'MarkerSize',8);

xlabel('$N$','Interpreter','latex');

ylabel('$t_{\rm max}$','Interpreter','latex');

set(gca,...
    'FontSize',25,...
    'FontName','Arial',...
    'LineWidth',1.5);

box on;