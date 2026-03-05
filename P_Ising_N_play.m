clear all
NN=7:1:12;
figure;hold
for nn=1:length(NN)
    L=NN(nn);
    N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;lbda=1;T=100;%T=10;
% fname=sprintf('Ising_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));

 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname]) 
%  delE_even{nn}=delE;
%  P_all{nn}=P;
%    plot(T,delE,'-o','Markersize',0.5,'LineWidth',2)
  plot(T,P,'-o','Markersize',0.5,'LineWidth',2)

  maxE(nn)=max(delE);
   maxP(nn)=max(P);
end

%  figure;

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
% ylabel('$\Delta E$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);

text(0.5, 0.9, '(d)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);

set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');

leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$', 'Location', 'best');
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

box on;
grid on;

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);

