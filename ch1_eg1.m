clear all
clf

syms m n x

%===========	Define basic function / test function	==========
fn = x - x^(n+1);

wm = x - x^(m+1);

%===========	Define L element / G element	==================
lmn = m*n/(m+n+1);

gm = m*(3*m+8)/(2*(m+2)*(m+4));

%===========	Get G L alpha coefficients Fn F under different N	=====================
for N = 1:4;

Mm = ones(N);
Nn = ones(N);

for t = 1:N
	Mm(t, :) = t;
	Nn(:, t) = t;
end

%=============	Get L G	===========================
L = subs(lmn, {m, n}, {Mm, Nn});
G = subs(gm, m, Mm(:, 1));

%============= Solve Matrix and get alpha coefficients	====================
Alpha = L\G;

%=============	Get Fn series	=================
Fn = subs(fn, n, (1:N)');

%=============	Get F	========================
F = Alpha' * Fn;

%=============	Plot result	===================
figure(N)
cla

t = 0:0.1:1;

%============	Result by MoM	==============
plot(t, subs(F, x, t), '*k');

hold on

%===========	Exact Result	==============
plot(t, 5*t/6-t.^2/2-t.^4/3);
legend('MoM', 'Exact')

xlabel('x')
ylabel('f')
title_p = ['N=', num2str(N)];
title(title_p)
grid on
hold off
end
