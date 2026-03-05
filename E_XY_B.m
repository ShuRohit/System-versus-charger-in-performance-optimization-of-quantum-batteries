clear all
L=12;
 
 N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;
strt=tic;
H_str= "J*Hxx+J*H8x+Hyy+J*Hzz+Hx+hz*Hz";   Hamiltonian
HC=hz*Hz; HB=(1+gma)*Hxx+(1-gma)*Hyy;
%sparse(SX(1)*SX(2)+SX(2)*SX(3)+SX(3)*SX(4)+SX(4)*SX(5)+SX(5)*SX(6)+SX(6)*SX(7)+SX(7)*SX(8)+SX(8)*SX(1)-Hxx)
Ev=eig(HB);
minValue = min(Ev(:));
[r, c]=find(Ev==minValue);
[ev,e]=eig(HB);
psi0=ev(:,r);

  ll=[0 1];
   for    l=1:length(ll)
       lbda=ll(l);
H=HC+(1-lbda)*HB;
rho_0=psi0*psi0';  
rho_t=rho_0;
dt=0.01;
T=0:dt:2;
AA=sprintf("E_Hz_TFIM_N%d_p%d_J%.1f_hz%d.1f",N,periodic,J,hz)
for  i=1:length(T)
     t=T(i);
     U=expm(-1i*H*t);
     rho_t=U'*rho_0*U;
     Wt=(trace(HB*rho_t))-trace(HB*rho_0);

    delE(i,l)=Wt;
    P(i,l)=Wt/t;
    fprintf(sprintf(" Done till gi =%d in time %.2f gma=%.1f lbda=%.1f,N=%d \n",i,toc(strt),gma,lbda,N));
end
for ii=1:length(T)-1
    Pi(ii,l)=(delE(ii+1)-delE(ii))/dt;
end
 fname=sprintf('XY_B_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
  save([folder fname]) 
  end
% fname=sprintf('QB_Hxx_Hz_N=%d_J=%.1f_hx=%d_hz=%d_p=%d.mat',N,J,hx,hz,periodic);
% folder=['/home/rohitshukla/Quantum_Battery/data/'];
% save([folder fname]) 
%%
figure;hold
 plot(T,delE,'-o','Markersize',2,'LineWidth',2)
leg1 = legend('$\lambda=0$', '$\lambda=1$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
 set(leg1,'Interpreter','latex');
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]); % Black text with LaTeX
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 48, 'Color', [0 0 0]);
 ylabel('$\Delta E$','Interpreter','latex','FontSize', 48,  'Color', [0 0 0])
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
 leg1 = legend('$\lambda=0$', '$\lambda=1$','$N=9$','$N=10$','$N=11$','$N=12$','$N=9$','$N=10$','$N=11$','$N=12$');
 set(leg1,'Interpreter','latex');
set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], 'YColor', [0 0 0]); % Dark axes and normal weight
text(0.5, 0.9, '(b)', 'Interpreter', 'latex', 'Units', 'normalized', ...
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

