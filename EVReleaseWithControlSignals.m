%% Different control signals as functions of time with different amplitudes 
% and shifts in time. 
% The simulations of the modulation of the EVs release rates
% for respected control signals as functions of time for different heart rates 
% ranging from 60 bpm to 120 bpm. 
% It is visible that the EVs release rates are modulated with respect to 
% the control signals.

clear
TT = [60./60,60./80,60./100,60./120]; % pacing period
n = length(TT); % number of periods
color2=[0 0.4470 0.7410];
color1 = [0.8500 0.3250 0.0980];
color3=[0.9290 0.6940 0.1250];
color4=[0.4940 0.1840 0.5560];
EV_rate = [];
tt1 = 1e-3.*[100, 1000, 1000, 1500,];
tt2 =tt1+1000e-3;
mm = [10, 15, 20, 25];
t = linspace(0,3,1000);
figure(5)
for kk=1:4
    Control_signal(kk,:) = control(3,tt1(kk),tt2(kk),mm(kk));
    subplot(2,4,kk)
    plot(1e3.*t,Control_signal(kk,:),'LineWidth',2)
    ylim([0 25])
    xlabel('{\it t} (ms)')
    ylabel('{\it J}_{control} (\muM/s)')
end

%%
for k = 1:4
    global t1;
    global t2;
    global m;
    t1 = tt1(k);
    t2 = tt2(k);
    m = mm(k);
    
    for j=1:n
        global T;
        T = TT(j);
        %% Calcium cycling
        dx = 1./1000; % numerical integral duration
        c0 = [.17;0.09;10;2.5e-5;5;.17]; % initial values 
        [t,c]=ode45(@diff_ca_eqs,linspace(0,3,1./dx),c0); % calcium dynamics
        tt(j,:) = t;
        for i=1:length(t)
        R_LTCC(j,i) = R_ca_L(c(i,6),c(i,1),t(i),T); % EVs from LTCC
        R_sub_membrane(j,i) = R_ca_m(c(i,1)); % EVs from submembrane space
            R(j,i) = R_LTCC(j,i)+ R_sub_membrane(j,i); % cumulative EV rate
        end
    end
    x = 4.*(k-1)+1;
    EV_rate(x:4*k,:)= R;
    subplot(2,4,k+4)
    semilogy(1e3.*t,R(1,:),'LineWidth',2,'color',color1)
    ylim([0.006491312547692,1])
    hold on
    semilogy(1e3.*t,R(2,:),'LineWidth',2,'color',color2)
        ylim([0.006491312547692,1])
    semilogy(1e3.*t,R(3,:),'LineWidth',2,'color',color3)
        ylim([0.006491312547692,1])
    semilogy(1e3.*t,R(4,:),'LineWidth',2,'color',color4)
    legend('60 bpm','80 bpm','100 bpm','120 bpm','location','northwest')
    xlabel('{\it t} (ms)')
    ylabel('EV release rate') 
end
