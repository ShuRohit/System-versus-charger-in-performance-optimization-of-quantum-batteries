clear all
L=12; N=L;J=1;hz=1;periodic=1;spin_matrix=0;gma=0.5;
strt=tic;
H_str= "J*Hxx+J*H8x+Hyy+J*Hzz+Hx+hz*Hz";   Hamiltonian
 HB=J*Hxx;HC=(1+gma)*Hxx+(1-gma)*Hyy;
Ev=eig(HB);
minValue = min(Ev(:));
[r, c]=find(Ev==minValue);
[ev,e]=eig(HB);
psi0=ev(:,r);
ll=[0 1];
  for l=1:length(ll)
      lbda=ll(l);
H=HC+(1-lbda)*HB;
rho_0=psi0*psi0';  
rho_t=rho_0;
dt=0.01;
T=0:dt:2;
AA=sprintf("E_Hz_TFIM_N%d_p%d_J%.1f_hz%d.1f",N,periodic,J,hz)
for  i=1:length(T)
     t=T(i);
     rho_t=expm(-1i*H*t)*rho_0*expm(-1i*H*t)';
     Wt=(trace(HB*rho_t))-trace(HB*rho_0);

    delE(i,l)=Wt;
    P(i,l)=Wt/t;
    fprintf(sprintf(" Done till gi =%d in time %.2f J=%.1f lbda=%.1f \n",i,toc(strt),J,lbda));
end
for ii=1:length(T)-1
    Pi(ii,l)=(delE(ii+1)-delE(ii))/dt;
end
  end
% fname=sprintf('B_Hxy_C_Hxx_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%d.mat',N,J,periodic,gma,lbda);
fname=sprintf('B_Hxx_C_Hxy_N=%d_J=%.1f_p=%d_gamma=%.1f_lambda=%d.mat',N,J,periodic,gma,lbda);
folder=['\Users\shuklar\Desktop\MATLAB\QB_Charging\data\'];
save([folder fname]) 
figure; hold on;
plot(T, delE(:,1), '-o', 'Markersize', 0.5, 'LineWidth', 3, 'Color', [1 0 0]);         % lambda = 0 (red)
plot(T, delE(:,2), '-s', 'Markersize', 0.5, 'LineWidth', 3, 'Color', [0.1 0.1 0.7]);   % lambda = 1 (dark blue)

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
ylabel('$\Delta E$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
text(0.5, 0.9, '(a)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);

set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');

leg1 = legend('$\lambda=0$', '$\lambda=1$', 'Location', 'best');
set(leg1, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

box on;
grid on;

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);

%% (b) P vs t
figure; hold on;
plot(T, P(:,1), '-o', 'Markersize', 0.5, 'LineWidth', 3, 'Color', [1 0 0]);           % lambda = 0 (red)
plot(T, P(:,2), '-s', 'Markersize', 0.5, 'LineWidth', 3, 'Color', [0.1 0.1 0.7]);     % lambda = 1 (dark blue)

xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);
ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 72, 'Color', [0 0 0]);

text(0.5, 0.9, '(b)', 'Interpreter', 'latex', 'Units', 'normalized', ...
    'FontSize', 48, 'FontWeight', 'normal', 'Color', [0 0 0]);

set(gca, 'FontWeight', 'normal', 'FontSize', 36, 'XColor', [0 0 0], ...
         'YColor', [0 0 0], 'LineWidth', 2, 'FontName', 'Arial');

leg2 = legend('$\lambda=0$', '$\lambda=1$', 'Location', 'best');
set(leg2, 'Interpreter', 'latex', 'FontSize', 36, 'TextColor', [0 0 0], ...
          'Box', 'off');

box on;
grid on;

set(gcf, 'PaperUnits', 'inches', 'PaperSize', [8 6], ...
         'PaperPositionMode', 'manual', 'PaperPosition', [0 0 8 6]);
