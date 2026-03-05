clear all
L=12;
jj=0.2:0.2:2;
for j=1:length(jj)
    J=jj(j);
 N=L;hz=1;periodic=1;spin_matrix=0;
strt=tic;
H_str= "J*Hxx+J*H8x+Hyy+J*Hzz+Hx+hz*Hz";   Hamiltonian
HC=hz*Hz; HB=J*Hxx;
%sparse(SX(1)*SX(2)+SX(2)*SX(3)+SX(3)*SX(4)+SX(4)*SX(5)+SX(5)*SX(6)+SX(6)*SX(7)+SX(7)*SX(8)+SX(8)*SX(1)-Hxx)
Ev=eig(HB);
minValue = min(Ev(:));
[r, c]=find(Ev==minValue);
[ev,e]=eig(HB);
psi0=ev(:,r);

  
      lbda=0.0;
H=HC+(1-lbda)*HB;
rho_0=psi0*psi0';  
rho_t=rho_0;
dt=0.01;
T=0:dt:2;
AA=sprintf("E_Hz_TFIM_N%d_p%d_J%.1f_hz%d.1f",N,periodic,J,hz);
for  i=1:length(T)
     t=T(i);
     U=expm(-1i*H*t);
     rho_t=U'*rho_0*U;
     Wt=(trace(HB*rho_t))-trace(HB*rho_0);

    delE(i)=Wt;
    P(i)=Wt/t;
    fprintf(sprintf(" Done till gi =%d in time %.2f J=%.1f lbda=%.1f,N=%d \n",i,toc(strt),J,lbda,N));
end
for ii=1:length(T)-1
    Pi(ii)=(delE(ii+1)-delE(ii))/dt;
end
EE(j,:)=delE;
PP(j,:)=P;
maxE(j)=max(delE);
maxP(j)=max(abs(Pi));
 fname=sprintf('Ising_B_J=%.1f_N=%d_lmda=%.1f_hz=%.2f_p=%d_T=%d.mat',J,N,lbda,hz,periodic,max(T));
 folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
 save([folder fname]) 
  end
% fname=sprintf('QB_Hxx_Hz_N=%d_J=%.1f_hx=%d_hz=%d_p=%d.mat',N,J,hx,hz,periodic);
% folder=['/home/rohitshukla/Quantum_Battery/data/'];
% save([folder fname]) 
%%
figure;hold
 plot(T,EE,'-o','Markersize',0.5,'LineWidth',2)
 xlabel('$t$','Interpreter','latex')
 ylabel('$\Delta E$','Interpreter','latex')
 leg1 = legend('$J=0.2$', '$J=0.4$','$J=0.6$','$J=0.8$','$J=1.0$','$J=1.2$', '$J=1.4$','$J=1.6$','$J=1.8$','$J=2.0$');
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
 plot(T,PP,'-o','Markersize',0.5,'LineWidth',2)
 xlabel('$t$','Interpreter','latex')
 ylabel('$P$','Interpreter','latex')
 leg1 = legend('$J=0.2$', '$J=0.4$','$J=0.6$','$J=0.8$','$J=1.0$','$J=1.2$', '$J=1.4$','$J=1.6$','$J=1.8$','$J=2.0$');
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
 plot(jj,maxE,'-o','Markersize',2,'LineWidth',2)
 xlabel('$N$','Interpreter','latex')
 ylabel('$\Delta E_{\rm max}$','Interpreter','latex')
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
set(gca, 'FontName', 'Arial')

%%
figure;hold
% Your data: jj = [...]; maxP = [...];

% --- Fit straight line in log-x vs y ---
xlog = log10(jj(:));   % log-scaled x
y    = maxP(:);

coeff = polyfit(xlog, y, 1);   % linear fit
slope = coeff(1);
intercept = coeff(2);

fprintf('Fit: P(N) = %.4f * log10(N) + %.4f\n', slope, intercept);

% Generate fitted curve
Nfit = logspace(log10(min(jj)), log10(max(jj)), 200); % keep log scale
Pfit = polyval(coeff, log10(Nfit));

% --- Plot ---
figure; hold on
plot(jj, maxP,'o','Markersize',8,'LineWidth',2)
set(gca,'XScale','log')   % log scale for x
plot(Nfit, Pfit,'-r','LineWidth',2)

xlabel('$N$','Interpreter','latex')
ylabel('$P_{\rm max}$','Interpreter','latex')
legend('Data', sprintf('Fit: $P = %.2f \\log_{10}(N) + %.2f$', slope, intercept), ...
       'Interpreter','latex','Location','best')
set(gca,'FontSize',30,'FontName','Arial')
box on
%%


figure; hold on

% Number of curves (based on your legend)
numCurves = 10;

% Plot each line in black
for k = 1:numCurves
    plot(T, EE, '-o', 'Markersize', 0.5, 'LineWidth', 2, 'Color', [0 0 0]);
end

xlabel('$t$','Interpreter','latex')
ylabel('$\Delta E$','Interpreter','latex')

leg1 = legend('$J=0.2$', '$J=0.4$','$J=0.6$','$J=0.8$','$J=1.0$','$J=1.2$', ...
              '$J=1.4$','$J=1.6$','$J=1.8$','$J=2.0$');
set(leg1,'Interpreter','latex');

set(gca,'FontSize',30)
set(gca, 'FontName', 'Arial')
box on
legend('show')

% Paper size settings
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [8 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 8 6]);
set(0,'defaultfigurepaperposition',[.01 .01 [8 6]-1]);

