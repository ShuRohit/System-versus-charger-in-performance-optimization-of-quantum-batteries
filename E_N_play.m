clear all
% NN=4:2:12;
figure;hold
J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;lbda=1;T=100;%
for i=[1 2 3 4 5 6]
    if i==1
        NN=3:2:12;
for nn=1:length(NN)
    L=NN(nn);
    N=L;
 fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
         end
    elseif i==2
        NN=4:2:12;
for nn=1:length(NN)
    L=NN(nn);
    N=L;
 fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
         end
      elseif i==3
          NN=4:2:12;
          for nn=1:length(NN)
    L=NN(nn);
    N=L;T=10;
fname=sprintf('Ising_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
           end
      elseif i==4
        NN=3:2:12;  
    for nn=1:length(NN)
    L=NN(nn);
    N=L;T=100;
 fname=sprintf('XY_long_N=%d_gama=%.2f_hz=%.2f_p=%d T=%d.mat',N,gma,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
    end
     elseif i==5
        NN=4:2:12;  
    for nn=1:length(NN)
    L=NN(nn);
    N=L;T=100;
 fname=sprintf('XY_long_N=%d_gama=%.2f_hz=%.2f_p=%d T=%d.mat',N,gma,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
     end
       elseif i==6
     for nn=1:length(NN)
    L=NN(nn);
    N=L;T=10;
 fname=sprintf('XY_N=%d_gama=%.2f_hz=%.2f_p=%d.mat',N,gma,hz,periodic);
folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname])
maxE(nn)=max(delE);
   maxP(nn)=max(P);
      end
      end
%%
%  leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
% 
%  set(leg1,'Interpreter','latex');
% %text(1, max(delE(1,:)),sprintf("$H_B=h_z \hat H_z$, $H_C=J\hat H_{x}$"),'Interpreter', 'latex','fontsize', 20)
% % set(gca, 'FontWeight', 'bold');
% set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
% text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
%     'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
%  ylabel('$\Delta E$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
% box on
% legend('show')
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [8 6]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 8 6]);
% set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
% set(gca, 'FontName', 'Arial')
% 
% 
% 
% %%
% figure;hold
%  plot(NN,maxE,'-o','Markersize',4,'LineWidth',2)
%  leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
%  set(leg1,'Interpreter','latex');
% set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
% text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
%     'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
% xlabel('$N$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
% ylabel('$\Delta E_{\rm max}$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
% box on
% legend('show')
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [8 6]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 8 6]);
% set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
% set(gca, 'FontName', 'Arial')

% %%
%  leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
%  set(leg1,'Interpreter','latex');
% set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
% text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
%     'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
% xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
%  ylabel('$P$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
% box on
% legend('show')
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [8 6]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 8 6]);
% set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
% set(gca, 'FontName', 'Arial')



%%
 plot(NN,maxE,'-o','Markersize',6,'LineWidth',3)
%  plot(NN,maxP,'-o','Markersize',6,'LineWidth',3)
 leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
 set(leg1,'Interpreter','latex');
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight

set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');
xlabel('$N$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
% ylabel('$P_{\rm max}$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
ylabel('$\Delta E_{\rm max}$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
box on
grid on;

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);
% leg1 = legend('${\rm Ising,~ATA}$', '${\rm Ising,~NN}$','${\rm XY, ATA}$',' ${\rm XY,~NN}$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$', 'Location', 'best');
leg1 = legend('${\rm Ising,~ATA~Odd~N}$','${\rm Ising,~ATA~Even~N}$', '${\rm Ising,~NN}$','${\rm XY,~ATA~Odd~N}$','${\rm XY,~ATA~Even~N}$',' ${\rm XY,~NN}$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$', 'Location', 'best');
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

end
text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);
