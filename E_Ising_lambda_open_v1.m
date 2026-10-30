%% =========================================================
% Open-system quantum battery:
% Stored Energy and Ergotropy under Lindblad dynamics
%
% d rho/dt = -i[H,rho]
%            + gamma D[sigma-]rho
%            + gamma D[sigma_z]rho
%
% Stored Energy:
% DeltaE(t) = Tr[HB rho(t)] - E0
%
% Ergotropy:
% W(t) = Tr[HB rho(t)] - E_passive(t)
%
% E_passive(t) = sum_n r_n^down E_n^up
%
% Author: Rohit
%% =========================================================

clear; 
strt = tic;

for pi=1:1
%% ================= PARAMETERS =============================

N = 8;                       % Number of spins
J = 1;
hz = 1;
for lbda =[1]
gma = 0.5;
periodic = 1;

% Relaxation and dephasing rates
gamma_list = [0 1e-3 1e-2 1e-1];

dt = 0.1;
T = 0:dt:100;

Nt = length(T);


%% ================= PAULI MATRICES ==========================

sx = sparse([0 1; 1 0]);

sy = sparse([0 -1i; 1i 0]);

sz = sparse([1 0; 0 -1]);

% sigma^- = |down><up|
sm = sparse([0 0; 1 0]);


%% ================= LOCAL OPERATORS =========================

dim = 2^N;

SX = cell(N,1);
SY = cell(N,1);
SZ = cell(N,1);
SM = cell(N,1);


for j = 1:N

    SX{j} = sparse(inkron(N,j,sx));

    SY{j} = sparse(inkron(N,j,sy));

    SZ{j} = sparse(inkron(N,j,sz));

    SM{j} = sparse(inkron(N,j,sm));

end


fprintf('Local operators constructed\n')


%% ================= HAMILTONIAN =============================

Hxx = sparse(dim,dim);
Hyy = sparse(dim,dim);


for j = 1:N-1

    Hxx = Hxx + SX{j}*SX{j+1};

    Hyy = Hyy + SY{j}*SY{j+1};

end


% Periodic boundary condition

if periodic == 1

    Hxx = Hxx + SX{N}*SX{1};

    Hyy = Hyy + SY{N}*SY{1};

end


% z-field Hamiltonian

Hz = sparse(dim,dim);


for j = 1:N

    Hz = Hz + SZ{j};

end


%% ================= BATTERY AND CHARGER =====================

% Battery Hamiltonian
%
% Here:
%
% HB = (1+gma) Hxx + (1-gma) Hyy
%
% Charger Hamiltonian:
%
% HC = J Hxx
if pi==1
 HB = J*Hz;  HC =  J*Hxx;
elseif pi==2
 HB = J*Hz;  HC = (1+gma)*Hxx + (1-gma)*Hyy;
elseif pi==3
 HB = J*Hxx;   HC = J*Hz;
elseif pi==4
  HB = (1+gma)*Hxx + (1-gma)*Hyy;   HC = J*Hz;
end
 % HB =J*Hxx ;   HC = (1+gma)*Hxx + (1-gma)*Hyy;
 % HB = (1+gma)*Hxx + (1-gma)*Hyy;   HC = J*Hxx;
% 

% Total Hamiltonian during charging

H = HC + (1-lbda)*HB;


fprintf('Hamiltonian constructed\n')


%% ================= INITIAL STATE ===========================

% Ground state of battery Hamiltonian

[V,D] = eigs(HB,1,'smallestreal');

psi0 = V(:,1);

% Initial density matrix

rho0 = psi0*psi0';


% Vectorized density matrix

rho_vec = reshape(rho0,dim^2,1);


% Identity matrix

I = speye(dim);


% Initial battery energy

E0 = real(trace(HB*rho0));


fprintf('Initial battery energy E0 = %.12f\n',E0)


%% ================= BATTERY ENERGY EIGENVALUES ==============

% Calculate eigenvalues of HB once.
%
% These are needed for calculating the passive energy.

Eb = eig(full(HB));

Eb = real(Eb);

% Sort battery energies in ascending order

Eb = sort(Eb,'ascend');


fprintf('Battery energy eigenvalues calculated\n')


%% =========================================================
% STORAGE ARRAYS
%% =========================================================

DeltaE_all = zeros(length(gamma_list),Nt);

Ergo_all = zeros(length(gamma_list),Nt);

PassiveEnergy_all = zeros(length(gamma_list),Nt);

Power_all = zeros(length(gamma_list),Nt);

ErgoPower_all = zeros(length(gamma_list),Nt);

Pmax_all = zeros(length(gamma_list),1);

ErgoPmax_all = zeros(length(gamma_list),1);


%% =========================================================
% LOOP OVER GAMMA
%% =========================================================

for ig = 1:length(gamma_list)

    gamma = gamma_list(ig);

    fprintf('\nGamma = %.3e\n',gamma)


    %% ================= HAMILTONIAN LIOUVILLIAN =============

    LH = -1i*(kron(I,H)-kron(H.',I));


    %% ================= DISSIPATOR ===========================

    Ldiss = sparse(dim^2,dim^2);


    for j = 1:N


        %% ---------------------------------------------------
        % Relaxation
        % D[sigma^-] rho
        %% ---------------------------------------------------

        A = SM{j};

        AdA = A'*A;


        Ldiss = Ldiss + gamma*(...
            kron(conj(A),A) ...
            -0.5*kron(I,AdA) ...
            -0.5*kron(AdA.',I));


        %% ---------------------------------------------------
        % Pure dephasing
        % D[sigma_z] rho
        %% ---------------------------------------------------

        A = SZ{j};

        AdA = A'*A;


        Ldiss = Ldiss + gamma*(...
            kron(conj(A),A) ...
            -0.5*kron(I,AdA) ...
            -0.5*kron(AdA.',I));


    end


    %% Total Liouvillian

    L = LH + Ldiss;


    fprintf('Liouvillian ready\n')


    %% ================= TIME EVOLUTION ======================

    rho_vec_t = rho_vec;


    DeltaE = zeros(1,Nt);

    Ergo = zeros(1,Nt);

    PassiveEnergy = zeros(1,Nt);

    Power = zeros(1,Nt);

    ErgoPower = zeros(1,Nt);


    for ii = 1:Nt


        %% ---------------------------------------------------
        % Time evolution
        %% ---------------------------------------------------

        if ii == 1

            rho_vec_t = rho_vec;

        else

            % Krylov exponential propagation
            %
            % rho(t+dt) = exp(L*dt) rho(t)

            rho_vec_t = expmv(L*dt,rho_vec_t);

        end


        %% ---------------------------------------------------
        % Reshape vectorized density matrix
        %% ---------------------------------------------------

        rho_t = reshape(rho_vec_t,dim,dim);


        %% ---------------------------------------------------
        % Enforce Hermiticity numerically
        %% ---------------------------------------------------

        rho_t = (rho_t + rho_t')/2;


        %% ---------------------------------------------------
        % Battery energy
        %% ---------------------------------------------------

        Et = real(trace(HB*rho_t));


        %% ---------------------------------------------------
        % Stored energy
        %
        % DeltaE = E_B(t) - E0
        %% ---------------------------------------------------

        DeltaE(ii) = Et - E0;


        %% ---------------------------------------------------
        % Eigenvalues of density matrix
        %% ---------------------------------------------------

        r = eig(full(rho_t));

        r = real(r);


        % Remove tiny numerical negative values

        r(r < 0 & r > -1e-12) = 0;


        % Sort populations in descending order

        r = sort(r,'descend');


        %% ---------------------------------------------------
        % Passive-state energy
        %
        % Largest population is assigned to
        % lowest battery energy.
        %% ---------------------------------------------------

        Epassive = sum(r .* Eb);


        PassiveEnergy(ii) = Epassive;


        %% ---------------------------------------------------
        % Ergotropy
        %
        % W = E_B - E_passive
        %% ---------------------------------------------------

        Ergo(ii) = Et - Epassive;


        %% ---------------------------------------------------
        % Power based on stored energy
        %% ---------------------------------------------------

        if T(ii) > 0

            Power(ii) = DeltaE(ii)/T(ii);

            % Ergotropy-based power

            ErgoPower(ii) = Ergo(ii)/T(ii);

        else

            Power(ii) = 0;

            ErgoPower(ii) = 0;

        end


    end


    %% ================= STORE RESULTS ========================

    DeltaE_all(ig,:) = DeltaE;

    Ergo_all(ig,:) = Ergo;

    PassiveEnergy_all(ig,:) = PassiveEnergy;

    Power_all(ig,:) = Power;

    ErgoPower_all(ig,:) = ErgoPower;


    %% Maximum stored-energy power

    Pmax_all(ig) = max(Power);


    %% Maximum ergotropy power

    ErgoPmax_all(ig) = max(ErgoPower);


    fprintf('Maximum stored-energy power = %.6f\n',...
            Pmax_all(ig))


    fprintf('Maximum ergotropy power = %.6f\n',...
            ErgoPmax_all(ig))


end
if pi==1
fname=sprintf('Open_B_nonint_C_Hxx_N=%d_J=%.1f_p=%d_lambda=%.1f.mat',N,J,periodic,lbda);
elseif pi==2
fname=sprintf('Open_B_nonint_C_Hxy_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%.1f.mat',N,J,periodic,gma,lbda);
elseif pi==3
fname=sprintf('Open_B_XX_C_nonint_C_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%.1f.mat',N,J,periodic,gma,lbda);
elseif pi==4
fname=sprintf('Open_B_XY_C_nonint_C_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%.1f.mat',N,J,periodic,gma,lbda);
end
%fname=sprintf('Ergo_B_Hxx_C_Hxy_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%.1f.mat',N,J,periodic,gma,lbda);
%fname=sprintf('Ergo_B_Hxy_C_Hxx_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%d.mat',N,J,periodic,gma,lbda);
 % folder=[ 'C:\Users\shuklar\OneDrive - Bar Ilan University\Desktop\BIU\MATLAB\QB_Charging\data\'];
 % save([folder fname]) 
end
end
%% =========================================================
% CHECK: STORED ENERGY VS ERGOTROPY
%% =========================================================

fprintf('\n========================================\n')
fprintf('Check: Stored Energy vs Ergotropy\n')
fprintf('========================================\n')


for ig = 1:length(gamma_list)

    difference = max(abs(...
        DeltaE_all(ig,:) - Ergo_all(ig,:)));

    fprintf('Gamma = %.3e : max |DeltaE-Ergo| = %.6e\n',...
        gamma_list(ig),difference)

end


%% =========================================================
% FIGURE 1: STORED ENERGY
%% =========================================================

figure('Color','w');
hold on;
gamma_labels = {...
    '$\gamma=0$',...
    '$10^{-3}$',...
    '$10^{-2}$',...
    '$10^{-1}$'};
line_style = {'-o','--s',':^','-.d'};

for ig = 1:length(gamma_list)

    plot(T,...
         DeltaE_all(ig,:),...
         line_style{ig},...
         'LineWidth',2,...
         'MarkerSize',0.03,...
         'DisplayName',gamma_labels{ig});

end

xlabel('$t$',...
       'Interpreter','latex',...
       'FontSize',28,...
       'Color','k')

ylabel('$\Delta E(t)$',...
       'Interpreter','latex',...
       'FontSize',28,...
       'Color','k')

ax = gca;

set(ax,...
    'Color','w',...
    'XColor','k',...
    'YColor','k',...
    'FontSize',25,...
    'FontName','Arial',...
    'LineWidth',1.5);

lgd = legend('show',...
       'Interpreter','latex',...
       'FontSize',20,...
       'Location','best');

set(lgd,...
    'Color','w',...
    'TextColor','k',...
    'EdgeColor','k');

box on;

% Panel label (a)
text(ax,0.02,0.98,'(a)',...
    'Units','normalized',...
    'Interpreter','latex',...
    'FontSize',25,...
    'Color','k',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','top');

%% =========================================================
% FIGURE 2: ERGOTROPY
%% =========================================================

figure('Color','w');
hold on;
% gamma_labels = {...
%     '$\gamma=0$',...
%     '$\gamma=10^{-3}$',...
%     '$\gamma=10^{-2}$',...
%     '$\gamma=10^{-1}$'};
for ig = 1:length(gamma_list)

    plot(T,...
        Ergo_all(ig,:),...
        line_style{ig},...
        'LineWidth',2,...
        'MarkerSize',0.03,...
        'DisplayName',gamma_labels{ig});

end

xlabel('$t$',...
    'Interpreter','latex',...
    'FontSize',28,...
    'Color','k')

ylabel('$\mathcal{W}(t)$',...
    'Interpreter','latex',...
    'FontSize',28,...
    'Color','k')

ax = gca;

set(ax,...
    'Color','w',...
    'XColor','k',...
    'YColor','k',...
    'FontSize',25,...
    'FontName','Arial',...
    'LineWidth',1.5);

lgd = legend('show',...
    'Interpreter','latex',...
    'FontSize',20,...
    'Location','best');

set(lgd,...
    'Color','w',...
    'TextColor','k',...
    'EdgeColor','k');

box on;

% Panel label (b)
text(ax,0.02,0.98,'(c)',...
    'Units','normalized',...
    'Interpreter','latex',...
    'FontSize',25,...
    'Color','k',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','top');

%% =========================================================
% FIGURE 3: STORED-ENERGY POWER
%% =========================================================

figure('Color','w');
hold on;

for ig = 1:length(gamma_list)

    plot(T,...
        Power_all(ig,:),...
        line_style{ig},...
        'LineWidth',2,...
        'MarkerSize',0.03,...
        'DisplayName',gamma_labels{ig});

end

xlabel('$t$',...
    'Interpreter','latex',...
    'FontSize',28,...
    'Color','k')

ylabel('$P_{\Delta E}(t)$',...
    'Interpreter','latex',...
    'FontSize',28,...
    'Color','k')

ax = gca;

set(ax,...
    'Color','w',...
    'XColor','k',...
    'YColor','k',...
    'FontSize',25,...
    'FontName','Arial',...
    'LineWidth',1.5);

lgd = legend('show',...
    'Interpreter','latex',...
    'FontSize',20,...
    'Location','best');

set(lgd,...
    'Color','w',...
    'TextColor','k',...
    'EdgeColor','k');

box on;

% Panel label (c)
text(ax,0.02,0.98,'(b)',...
    'Units','normalized',...
    'Interpreter','latex',...
    'FontSize',25,...
    'Color','k',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','top');