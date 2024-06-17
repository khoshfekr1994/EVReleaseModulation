function f=control(tt,t1,t2,m)

f = zeros(1,1000);
t = linspace(0,tt,1000);
for tt=1:length(t)
    if t(tt) >t1 && t(tt) < t2
        f(tt) = m;
    end
end
end