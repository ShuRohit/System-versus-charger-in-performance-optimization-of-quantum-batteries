clear all
L=10; N=L;J=1;hz=1;periodic=1;spin_matrix=0;%T=20;
T=10;
figure;hold

for i=[1 2 3 4]
% NN=[0:1:5];
 NN=0:0.2:1;
      if i==1
         for nn=1:length(NN)
      lbda=NN(nn); T=20;

 fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
  
         end
      %%   
      elseif i==2
           for nn=1:length(NN)
      lbda=NN(nn); T=10;

fname=sprintf('Ising_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
 

           end
      elseif i==3
     for nn=1:length(NN)
      lbda=NN(nn); T=10;

fname=sprintf('XY_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
     end
       elseif i==4
     for nn=1:length(NN)
      lbda=NN(nn); T=10;

fname=sprintf('XY_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
      end
      end

 
  
 
 
%
% plot(NN,maxE,'-o','Markersize',6,'LineWidth',3)
plot(NN,maxP,'-o','Markersize',6,'LineWidth',3)
 set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
% text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
%     'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
xlabel('$\lambda$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
ylabel('$P_{\rm max}$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
% ylabel('$\Delta E_{\rm max}$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
box on

grid on;
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);
leg1 = legend('${\rm Ising,~ATA}$', '${\rm Ising,~NN}$','${\rm XY, ATA}$',' ${\rm XY,~NN}$','Location', 'best');
% leg1 = legend('${\rm Ising,~ATA~Odd~N}$','${\rm Ising,~ATA~Evenn~N}$', '${\rm Ising,~NN}$','${\rm XY,~ATA~Odd~N}$','${\rm XY,~ATA~Even~N}$',' ${\rm XY,~NN}$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$');
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');
end
text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);