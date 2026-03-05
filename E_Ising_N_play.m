clear all
NN=4:2:12;
% figure;hold
for nn=1:length(NN)
    L=NN(nn);
    N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;lbda=1;T=100;%T=10;
% fname=sprintf('Ising_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));

 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname]) 
 delE_even{nn}=delE;
%    plot(T,delE,'-o','Markersize',0.5,'LineWidth',2)
%   plot(T,P,'-o','Markersize',0.5,'LineWidth',2)

  maxE(nn)=max(delE);
   maxP(nn)=max(P);
end
NN=3:2:12;
% figure;hold
for nn=1:length(NN)
    L=NN(nn);
    N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;lbda=1;T=100;%T=10;
% fname=sprintf('Ising_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));

 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname]) 
 delE_odd{nn}=delE;
%    plot(T,delE,'-o','Markersize',0.5,'LineWidth',2)
%   plot(T,P,'-o','Markersize',0.5,'LineWidth',2)

  maxE(nn)=max(delE);
   maxP(nn)=max(P);
end
 figure;

% Adjust figure size and spacing manually
set(gcf, 'Units', 'normalized', 'Position', [0.2, 0.1, 0.5, 0.8]); % Tall figure

% ----------- (a) Odd N subplot on top -----------
subplot('Position', [0.15, 0.55, 0.75, 0.38]);
hold on;
N_odd = [3, 5, 7, 9, 11];
for i = 1:length(N_odd)
    plot(T, delE_odd{i}, 'LineWidth', 2);
end
leg1 = legend(arrayfun(@(n) sprintf('$N=%d$', n), N_odd, 'UniformOutput', false));
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

ylabel('$\Delta E$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
text(0.05, 0.95, '($c_1$)', 'Units', 'normalized', 'Interpreter', 'latex', ...
     'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);
 set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial','XTickLabel', []);
% set(gca, 'FontSize', 48, 'FontName', 'Arial', ...
%          'XColor', [0 0 0], 'YColor', [0 0 0], 'XTickLabel', []); % <<< X-axis labels removed
xlim([0 30]);
box on;
grid on;
% ----------- (b) Even N subplot on bottom -----------
subplot('Position', [0.15, 0.08, 0.75, 0.38]);
hold on;
N_even = [4, 6, 8, 10, 12];
T_fine = linspace(min(T), 30, 1000);
for i = 1:length(N_even)
    delE_interp = interp1(T, delE_even{i}, T_fine, 'spline');
    plot(T_fine, delE_interp, 'LineWidth', 2);
end
leg2 = legend(arrayfun(@(n) sprintf('$N=%d$', n), N_even, 'UniformOutput', false));
set(leg2, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
ylabel('$\Delta E$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
text(0.5, 0.9, '($c_2$)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');
xlim([0 30]);
box on;

% ----------- Export settings for PDF or PNG -----------
set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 10], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 10]);


