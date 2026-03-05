clear all
L=10; N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;
strt=tic;
H_str= "J*Hxx+J*H8x+Hyy+J*Hzz+Hx+hz*Hz";   Hamiltonian
HB=hz*Hz; HC=(1+gma)*Hxx+(1-gma)*Hyy;
Ev=eig(HB);
minValue = min(Ev(:));
[r, c]=find(Ev==minValue);
[ev,e]=eig(HB);
psi0=ev(:,r);
ll=0:0.2:2;
  for l=1:length(ll)
      lbda=ll(l);
H=HC+(1-lbda)*HB;
rho_0=psi0*psi0';  
rho_t=rho_0;
dt=0.01;
T=0:dt:10;
AA=sprintf("E_Hz_TFIM_N%d_p%d_J%.1f_hz%d.1f",N,periodic,J,hz)
for  i=1:length(T)
     t=T(i);
     rho_t=expm(-1i*H*t)*rho_0*expm(-1i*H*t)';
     Wt=(trace(HB*rho_t))-trace(HB*rho_0);

    delE(i)=Wt;
    P(i)=Wt/t;
    fprintf(sprintf(" Done till gi =%d in time %.2f J=%.1f lbda=%.1f,N=%d \n",i,toc(strt),J,lbda,N));
end
for ii=1:length(T)-1
    Pi(ii)=(delE(ii+1)-delE(ii))/dt;
end
fname=sprintf('XY_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 save([folder fname]) 
  end
% fname=sprintf('QB_Hxx_Hz_N=%d_J=%.1f_hx=%d_hz=%d_p=%d.mat',N,J,hx,hz,periodic);
% folder=['/home/rohitshukla/Quantum_Battery/data/'];
% save([folder fname]) 
% figure;hold
%  plot(T,delE,'-o','Markersize',2,'LineWidth',2)
%  xlabel('$t$','Interpreter','latex')
%  ylabel('$\Delta E$','Interpreter','latex')
%  leg1 = legend('$\lambda=0.0$', '$\lambda=0.2$','$\lambda=0.4$','$\lambda=0.6$','$\lambda=0.8$','$\lambda=1.0$');
%  set(leg1,'Interpreter','latex');
% %text(1, max(delE(1,:)),sprintf("$H_B=h_z \hat H_z$, $H_C=J\hat H_{x}$"),'Interpreter', 'latex','fontsize', 20)
% set(gca,'FontSize',30)
% box on
% legend('show')
% set(gcf, 'PaperUnits', 'inches');
% set(gcf, 'PaperSize', [8 6]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperPosition', [0 0 8 6]);
% set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
% set(gca, 'FontName', 'Arial')


%%
figure;hold
plot(T,P,'-o','Markersize',2,'LineWidth',2)
xlabel('$t$','Interpreter','latex')
ylabel('$P$','Interpreter','latex')
leg1 = legend('$\lambda=0.0$', '$\lambda=0.2$','$\lambda=0.4$','$\lambda=0.6$','$\lambda=0.8$','$\lambda=1.0$');
set(leg1,'Interpreter','latex');
set(gca,'FontSize',30)
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
 plot(ll,max(P),'-o','Markersize',2,'LineWidth',2)
 xlabel('$\lambda$','Interpreter','latex')
 ylabel('$P_{\rm max}$','Interpreter','latex')
 leg1 = legend('$\lambda=0.0$', '$\lambda=0.2$','$\lambda=0.4$','$\lambda=0.6$','$\lambda=0.8$','$\lambda=1.0$');
 set(leg1,'Interpreter','latex');
%text(1, max(delE(1,:)),sprintf("$H_B=h_z \hat H_z$, $H_C=J\hat H_{x}$"),'Interpreter', 'latex','fontsize', 20)
set(gca,'FontSize',30)
box on
legend('show')
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [8 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 8 6]);
set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);
set(gca, 'FontName', 'Arial')

