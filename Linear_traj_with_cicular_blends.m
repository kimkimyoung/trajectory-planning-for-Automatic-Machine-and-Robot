% linear trajectory with circular blends (Page 59)
% input: t0, t1, q0, q1
% T = t1 - t0
% h = q1 - q0
% alfa = acos((2 * h^2 + T * sqrt(T^2 - 3 * h^2)) / (h^2 + T^2))
% circular time Ta = h * sin(alfa)

clear all;
close all;

t0 = 2;
t1 = 8;
q0 = 5;
q1 = 8;

h = q1 - q0;
T = t1 - t0;

alfa = acos((2 * h^2 + T * sqrt(T^2 - 3 * h^2)) / (h^2 + T^2));
a1 = tan(alfa);
a0 = h * (cos(alfa) - 1) / cos(alfa) + q0;
T_treshold = sqrt(3) * (q1 - q0);
Ta = h * sin(alfa);

i = 1;
for t = t0:0.002:t1
    if (t < t0 + Ta)
        q(i) = h * (1 - sqrt(1 - ((t - t0)/h)^2)) + q0;
        qd(i) = (t - t0) / sqrt(h^2 - (t - t0)^2);
        qdd(i) = h^2 / sqrt((h^2 - (t - t0)^2)^3);
    elseif (t < t1 - Ta)
        q(i) = a0 + a1 * (t - t0);
        qd(i) = a1;
        qdd(i) = 0;
    else
        q(i) = q0 + sqrt(h^2 - (t1 - t)^2);
        qd(i) = (t1 - t) / sqrt(h^2 - (t1 - t)^2);
        qdd(i) = - h^2 / sqrt((h^2 - (t1 - t)^2)^3);
    end
    i = i+1;
end
figure(1)
subplot(3,1,1)
plot(t0:0.002:t1, q);
grid on;
title('关节角(°)');
subplot(3,1,2)
plot(t0:0.002:t1, qd);
grid on;
title('角速度(°/s)');
subplot(3,1,3)
plot(t0:0.002:t1, qdd);
grid on;
title('角加速度(°/s^2)');
