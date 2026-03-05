clear all
NN=7:1:12;
figure;hold

for nn=1:length(NN)
    L=NN(nn);
    N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;
N
 fname=sprintf('XY_N=%d_gama=%.2f_hz=%.2f_p=%d.mat',N,gma,hz,periodic);
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 load([folder fname]) 
%   plot(T,delE,'-o','Markersize',0.5,'LineWidth',2)
  plot(T,P,'-o','Markersize',0.5,'LineWidth',2)

  maxE(nn)=max(delE);
   maxP(nn)=max(P);
  end


 


%  leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');

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

%%
 leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
 set(leg1,'Interpreter','latex');
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
 ylabel('$P$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
box on
legend('show')
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [8 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 8 6]);
set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
set(gca, 'FontName', 'Arial')



%%
figure;hold
 plot(NN,maxP,'-o','Markersize',4,'LineWidth',2)
 leg1 = legend('$N=7$', '$N=8$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
 set(leg1,'Interpreter','latex');
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
xlabel('$N$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
ylabel('$P_{\rm max}$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
box on
legend('show')
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [8 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 8 6]);
set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
set(gca, 'FontName', 'Arial')