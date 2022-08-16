function J = SingularIntegration(x, f, x0)
	% This function computes the following integral: J = int f(x)/(x0 - x) dx
	% The integration uses a method thats called singularity subtraction.

	n = length(x);
	f0 = interp1(x, f, x0);

	integrand_num = zeros(1, n);

	for i = 1:n
		if (x(i) - x0) ~= 0
			integrand_num(i) = f(i)/(x0 - x(i)) - f0/(x0 - x(i));
		end
	end

	J = trapz(x, integrand_num);

	J = J + f0*(-log(x(n) - x0) + log(x0 - x(1)));
end