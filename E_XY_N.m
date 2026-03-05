clear all
 LL=3:1:12; 
    for n=1:length(LL)
        L=LL(n);
   
N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;
strt=tic;
H_str= "J*Hxx+J*H8x+Hyy+J*Hzz+Hx+hz*Hz";   Hamiltonian
HB=hz*Hz; HC=(1+gma)*Hxx+(1-gma)*Hyy;
Ev=eig(HB);
minValue = min(Ev(:));
[r, c]=find(Ev==minValue);
[ev,e]=eig(HB);
psi0=ev(:,r);
ll=1;
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
     U=expm(-1i*H*t);
     rho_t=U'*rho_0*U;
     Wt=(trace(HB*rho_t))-trace(HB*rho_0);

    delE(i)=Wt;
    P(i)=Wt/t;
    fprintf(sprintf(" Done till gi =%d in time %.2f N=%d J=%.1f lbda=%.1f \n",i,toc(strt),N,J,lbda));
end
for ii=1:length(T)-1
    Pi(ii)=(delE(ii+1)-delE(ii))/dt;
end
  end
  fname=sprintf('XY_N=%d_gama=%.2f_hz=%.2f_p=%d.mat',N,gma,hz,periodic);
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 save([folder fname]) 
 plot(T,delE,'-o','Markersize',2,'LineWidth',2)
    end
% fname=sprintf('QB_Hxx_Hz_N=%d_J=%.1f_hx=%d_hz=%d_p=%d.mat',N,J,hx,hz,periodic);
% folder=['/home/rohitshukla/Quantum_Battery/data/'];
% save([folder fname]) 
% figure;hold
 plot(T,delE,'-o','Markersize',2,'LineWidth',2)
 xlabel('$t$','Interpreter','latex')
 ylabel('$\Delta E$','Interpreter','latex')
 leg1 = legend('$N=3$', '$N=4$','$N=5$','$N=6$','$N=7$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$');
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


%%
figure;hold

 xlabel('$N$','Interpreter','latex')
 ylabel('$\Delta E_{\rm max}$','Interpreter','latex')
%  leg1 = legend('$N=3$', '$N=4$','$N=5$','$N=6$','$N=7$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$');
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
%%
% leg1 = legend('${\rm Ising,~ATA}$', '${\rm Ising,~NN}$','${\rm XY, ATA}$',' ${\rm XY,~NN}$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$');
leg1 = legend('${\rm Ising,~ATA~Odd~N}$','${\rm Ising,~ATA~Evenn~N}$', '${\rm Ising,~NN}$','${\rm XY,~ATA~Odd~N}$','${\rm XY,~ATA~Even~N}$',' ${\rm XY,~NN}$','$N=8$','$N=9$','$N=10$','$N=11$','$N=12$');

 set(leg1,'Interpreter','latex');