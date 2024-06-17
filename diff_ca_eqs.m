function dc = diff_ca_eqs(t,c)
% t is time, c(1)=c_s, c(2)=c_b, c(3)= c_SR, c(4)=J_r, c(5)=c_JSR, c(6)=c_open

global T;
global t1;
global t2;
global m;
v_i = 1e-4; % mu l, cell volume
v_s = 0.1.*v_i; % sub-membrane volume
v = v_i./v_s;
tau_s = 10; % ms, submembrane diffusion time constant
tau_r = 20; %ms, spark life-time
g = 1.5e4; % sparks/muM, release current strength
tau_a = 50; % ms, relaxation time of cj' to cj
dc = zeros(6,1); % the number of ODEs is 6
f = 0.01.*1e-6;
alpha = 5.180e-15; %mu mol pA-1 ms-1
vol_mu = 2.618e-17; %l
B_mu = 264; % ms-1
%% c_s
dc(1) = Betta(c(1)).*(v.*(c(4) - (c(1) - c(2))./(tau_s) - ...
    I_ca(c(1),t,T,t1,t2,m) + I_naca(c(1),t,T)) - I_trpn_s(c(1)) );
dc(2) = Betta(c(2)) .* (    (c(1) - c(2))./(tau_s) - I_up(c(2))...
                        - I_trpn_s(c(2))    );
dc(3) = -c(4) + I_up(c(2));
dc(4) = g.*I_ca(c(1),t,T,t1,t2,m).* QQ(c(5)) - c(4)./tau_r;
dc(5) = (c(3) - c(5))./(tau_a);
dc(6) = -f.*( alpha.*M_I_ca(c(1),t,T)./(vol_mu) - 1e-6.*B_mu.* (c(6) - c(1)) );

end