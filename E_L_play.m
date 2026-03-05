clear all
L=10; N=L;J=1;hz=1;periodic=1;spin_matrix=0;%T=20;
T=10;
 figure;hold

% NN=0:1:5;
 
 NN=0:0.2:5;
               for nn=1:length(NN)
      lbda=NN(nn);
       fname=sprintf('XY_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));

%  fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
%    plot(T,delE,'-o','Markersize',0.5,'LineWidth',2)
 plot(T,P,'-o','Markersize',0.5,'LineWidth',2)
               end
%%
 

%%


xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
% ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);

text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);

set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');

leg1 = legend('$\lambda=0$', '$\lambda=1$','$\lambda=2$','$\lambda=3$','$\lambda=4$','$\lambda=5$', 'Location', 'best');
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

box on;
grid on;

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);
     
     figure; hold
  plot(NN, maxP, '-o', 'Color', [1 0 0], 'MarkerSize', 4.0, 'LineWidth', 2)

   xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
ylabel('$P_{\rm max}$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
% ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);

text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);

set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');

leg1 = legend('$\lambda=0.0$', '$\lambda=0.2$','$\lambda=0.4$','$\lambda=0.6$','$\lambda=0.8$','$\lambda=1.0$', 'Location', 'best');
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

box on;
grid on;

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);