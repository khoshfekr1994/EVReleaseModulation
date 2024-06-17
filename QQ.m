function f = QQ(d)
% Release function

u = 11.3; % s^-1, release slope
s = 977; % mu M/ms, release function parameter

if d<50
    f=0;
elseif d < 115
    f = d - 50;
else
    f = u.*d + s;
end

end