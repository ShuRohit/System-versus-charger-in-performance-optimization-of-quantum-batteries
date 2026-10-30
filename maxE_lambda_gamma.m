
%% ========================================================================
% XY BATTERY:
% GENERATE AND PLOT DeltaE_max VS lambda FOR FOUR Gamma VALUES
%
% H_B = J sum_j [ (1+Gamma) Sx_j Sx_{j+1}
%                +(1-Gamma) Sy_j Sy_{j+1} ]
%
% H_C = hz sum_j Sz_j
%
% H_ch = (1-lambda) H_B + H_C
%
% Initial state = ground state of H_B
%
% ========================================================================

clear;
% clc;
% close all;

tic;

%% ========================================================================
% PARAMETERS
% ========================================================================

N = 10;

J  = 1;
hz = 1;

periodic = true;

% Four Gamma values to investigate
Gamma_list = [0 0.2 0.5 0.7 0.9 1];

% Lambda grid
lambda_list = linspace(0,1,101);

% Time grid
tmax = 10;
Nt   = 501;

tlist = linspace(0,tmax,Nt);

Ng = length(Gamma_list);
Nl = length(lambda_list);

%% ========================================================================
% DIMENSION
% ========================================================================

dim = 2^N;

%% ========================================================================
% PAULI MATRICES
% ========================================================================

sx = [0 1; 1 0];
sy = [0 -1i; 1i 0];
sz = [1 0; 0 -1];

id2 = eye(2);

%% ========================================================================
% SINGLE-SITE OPERATORS
% ========================================================================

Sx = cell(N,1);
Sy = cell(N,1);
Sz = cell(N,1);

for j = 1:N

    opx = 1;
    opy = 1;
    opz = 1;

    for k = 1:N

        if k == j

            opx = kron(opx,sx);
            opy = kron(opy,sy);
            opz = kron(opz,sz);

        else

            opx = kron(opx,id2);
            opy = kron(opy,id2);
            opz = kron(opz,id2);

        end

    end

    Sx{j} = opx;
    Sy{j} = opy;
    Sz{j} = opz;

end

%% ========================================================================
% PRECOMPUTE XX AND YY BOND OPERATORS
% ========================================================================

XX = zeros(dim);
YY = zeros(dim);

for j = 1:N

    if j < N

        jp = j + 1;

    else

        if periodic
            jp = 1;
        else
            continue;
        end

    end

    XX = XX + Sx{j}*Sx{jp};
    YY = YY + Sy{j}*Sy{jp};

end

%% ========================================================================
% CHARGER HAMILTONIAN
% ========================================================================

HC = zeros(dim);

for j = 1:N
    HC = HC + hz*Sz{j};
end

%% ========================================================================
% PREALLOCATE
% ========================================================================

DeltaE_max = zeros(Ng,Nl);

lambda_opt = zeros(Ng,1);

Emax_opt = zeros(Ng,1);

E0_all = zeros(Ng,1);

%% ========================================================================
% LOOP OVER GAMMA
% ========================================================================

for ig = 1:Ng

    Gamma = Gamma_list(ig);

    fprintf('Gamma = %.2f  (%d/%d)\n',...
        Gamma,ig,Ng);

    %% ====================================================================
    % BATTERY HAMILTONIAN
    % ====================================================================

    HB = J*(1+Gamma)*XX ...
       + J*(1-Gamma)*YY;

    %% ====================================================================
    % BATTERY GROUND STATE
    % ====================================================================

    [VB,EB] = eig(HB);

    EvalsB = real(diag(EB));

    [E0,idx0] = min(EvalsB);

    psi0 = VB(:,idx0);

    E0_all(ig) = E0;

    %% ====================================================================
    % LOOP OVER LAMBDA
    % ====================================================================

    for il = 1:Nl

        lambda = lambda_list(il);

        %% ---------------------------------------------------------------
        % CHARGING HAMILTONIAN
        % ---------------------------------------------------------------

        Hch = (1-lambda)*HB + HC;

        %% ---------------------------------------------------------------
        % DIAGONALIZE H_ch
        % ---------------------------------------------------------------

        [V,E] = eig(Hch);

        Evals = real(diag(E));

        %% ---------------------------------------------------------------
        % INITIAL STATE IN H_ch EIGENBASIS
        % ---------------------------------------------------------------

        c = V' * psi0;

        %% ---------------------------------------------------------------
        % H_B IN H_ch EIGENBASIS
        % ---------------------------------------------------------------

        A = V' * HB * V;

        %% ---------------------------------------------------------------
        % ALL TIMES SIMULTANEOUSLY
        % ---------------------------------------------------------------

        D = c .* exp(-1i*Evals*tlist);

        %% ---------------------------------------------------------------
        % BATTERY ENERGY
        % ---------------------------------------------------------------

        AD = A * D;

        E_B_t = real(sum(conj(D).*AD,1));

        %% ---------------------------------------------------------------
        % STORED ENERGY
        % ---------------------------------------------------------------

        DeltaE_t = E_B_t - E0;

        DeltaE_max(ig,il) = max(DeltaE_t);

    end

    %% ====================================================================
    % OPTIMUM
    % ====================================================================

    [Emax_opt(ig),idxopt] = max(DeltaE_max(ig,:));

    lambda_opt(ig) = lambda_list(idxopt);

end

%% ========================================================================
% COMPUTATION TIME
% ========================================================================

elapsed_time = toc;

fprintf('\n');
fprintf('Total computation time = %.2f seconds\n',elapsed_time);

%% ========================================================================
% PRINT RESULTS
% ========================================================================

fprintf('\n');
fprintf('============================================================\n');
fprintf('Gamma       lambda_opt       DeltaE_max\n');
fprintf('============================================================\n');

for ig = 1:Ng

    fprintf('%.2f          %.4f          %.8f\n',...
        Gamma_list(ig),...
        lambda_opt(ig),...
        Emax_opt(ig));

end

%% ========================================================================
% PLOT DeltaE_max VS lambda
% ========================================================================

figure;

hold on;
box on;

for ig = 1:Ng

    plot(lambda_list,...
         DeltaE_max(ig,:),...
         'LineWidth',2,...
         'DisplayName',...
         sprintf('$\\Gamma=%.1f$',Gamma_list(ig)));

    % Mark optimum
    plot(lambda_opt(ig),...
         Emax_opt(ig),...
         'ko',...
         'MarkerFaceColor','w',...
         'MarkerSize',7,...
         'LineWidth',1.5,...
         'HandleVisibility','off');

end

xlabel('$\lambda$',...
       'Interpreter','latex',...
       'FontSize',16);

ylabel('$\Delta E_{\max}$',...
       'Interpreter','latex',...
       'FontSize',16);

legend('Interpreter','latex',...
       'Location','best',...
       'FontSize',12);

set(gca,...
    'FontSize',13,...
    'LineWidth',1);

grid on;

%% ========================================================================
% FIX FIGURE SIZE: 8 x 6 INCHES
% ========================================================================

fig = gcf;

set(fig,...
    'Units','inches',...
    'Position',[1 1 8 6],...
    'PaperUnits','inches',...
    'PaperPosition',[0 0 8 6],...
    'PaperSize',[8 6]);

%% ========================================================================
% SAVE FIGURE
% ========================================================================

exportgraphics(fig,...
    'DeltaEmax_vs_lambda_four_Gamma.pdf',...
    'ContentType','vector');

exportgraphics(fig,...
    'DeltaEmax_vs_lambda_four_Gamma.png',...
    'Resolution',600);

%% ========================================================================
% SAVE GENERATED DATA
% ========================================================================

save('DeltaEmax_vs_lambda_four_Gamma.mat',...
     'DeltaE_max',...
     'lambda_list',...
     'Gamma_list',...
     'lambda_opt',...
     'Emax_opt',...
     'E0_all',...
     'N',...
     'J',...
     'hz',...
     'periodic',...
     'tmax',...
     'Nt',...
     'tlist');

fprintf('\n');
fprintf('Data saved to:\n');
fprintf('DeltaEmax_vs_lambda_four_Gamma.mat\n');

fprintf('Figures saved to:\n');
fprintf('DeltaEmax_vs_lambda_four_Gamma.pdf\n');
fprintf('DeltaEmax_vs_lambda_four_Gamma.png\n');

fprintf('============================================================\n');
