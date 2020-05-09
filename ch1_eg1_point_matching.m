clear all
clf

syms x xm m n

g = 1 + 4*x^2;

fn = x - x^(n+1);

wm = dirac(x - xm);

%================	N = 1:4	===============
for N = 1:4

	lmn = n*(n+1)*(m/(N+1))^(n-1);
	gm = 1+4*(m/(N+1))^2;

	Mn = ones(N);
	Nn = ones(N);

	for t = 1:N
		Mn(t, :) = t;
		Nn(:, t) = t;
	end

	L = subs(lmn, {m, n}, {Mn, Nn});
	G = subs(gm, m, Mn(:, 1));

	Alpha = L\G;

	disp('L =')
	disp(L)
	disp('G =')
	disp(G)
	disp('Alpha =')
	disp(Alpha)


	F = Alpha' * subs(fn, n, (1:N)');

	%===========	Plot Result	==================
	figure(N)
	cla

	t = 0:0.1:1;
	plot(t, subs(F, x, t), '*k')

	hold on

	%===========	Exact Result	==============
	plot(t, 5*t/6-t.^2/2-t.^4/3);
	legend('MoM', 'Exact')
	xlabel('x');
	ylabel('f');
	title_p = ['N=', num2str(N)];
	title(title_p)
	grid on 

	hold off
end
