clear all
L=10; 
N=L;J=1;hz=1;periodic=1;spin_matrix=0;
strt=tic;
H_str= "J*Hxx+Hxx2+Hxx3+Hxx4+Hxx5+Hxx6+J*Hyy+Hyy2+Hyy3+Hyy4+Hyy5+Hyy6+hz*Hz";   Hamiltonian_Battery
HB=hz*Hz; 
if L==3
    HC=J*(Hxx);
elseif L==4 || L==5
    HC=J*(Hxx+Hxx2/2);
elseif L==6 || L==7
    HC=J*(Hxx+Hxx2/2+Hxx3/4);
elseif L==8 || L==9
    HC=J*(Hxx+Hxx2/2+Hxx3/4+Hxx4/8);
elseif L==10 || L==11
    HC=J*(Hxx+Hxx2/2+Hxx3/4+Hxx4/8+Hxx5/16);
elseif L==12
    HC=J*(Hxx+Hxx2/2+Hxx3/4+Hxx4/8+Hxx5/16+Hxx6/32);
end

Ev=eig(HB);
minValue = min(Ev(:));
[r, c]=find(Ev==minValue);
[ev,e]=eig(HB);
psi0=ev(:,r);
ll=0:0.2:5;
  for l=1:length(ll)
      lbda=ll(l);
H=HC+(1-lbda)*HB;
rho_0=psi0*psi0';  
rho_t=rho_0;
dt=0.01;
T=0:dt:20;
AA=sprintf("E_Hz_TFIM_N%d_p%d_J%.1f_hz%d.1f",N,periodic,J,hz)
for  i=1:length(T)
     t=T(i);
     rho_t=expm(-1i*H*t)*rho_0*expm(-1i*H*t)';
     Wt=(trace(HB*rho_t))-trace(HB*rho_0);

    delE(i)=Wt;
    P(i)=Wt/t;
    fprintf(sprintf(" Done till gi =%d in time %.2f J=%.1f lbda=%.1f \n",i,toc(strt),J,lbda));
end
for ii=1:length(T)-1
    Pi(ii)=(delE(ii+1)-delE(ii))/dt;
end
fname=sprintf('Ising_long_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
  save([folder fname]) 
  end
% fname=sprintf('QB_Hxx_Hz_N=%d_J=%.1f_hx=%d_hz=%d_p=%d.mat',N,J,hx,hz,periodic);
% folder=['/home/rohitshukla/Quantum_Battery/data/'];
% save([folder fname]) 
figure;hold
 plot(T,delE,'-o','Markersize',2,'LineWidth',2)
 xlabel('$t$','Interpreter','latex')
 ylabel('$\Delta E$','Interpreter','latex')
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
 plot(ll,max(delE),'-o','Markersize',2,'LineWidth',2)
 xlabel('$\lambda$','Interpreter','latex')
 ylabel('$\Delta E_{\rm max}$','Interpreter','latex')
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

