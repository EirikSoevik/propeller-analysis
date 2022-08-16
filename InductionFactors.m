function [i_A, i_T] = InductionFactors(r, r0, beta_i, Z)
	% This function calculates the induction factors as a specified in 
    % "Calculation of Performance and Cavitation Characteristics of 
    % Propellers" by Van Oossanen. In the input variables, r is the running
    % point, while r0 is the fixed point. In the original reference, x is
    % the fixed point and x0 is the running point. This is the reason that 
    % x_x0 = r0/r, rather than x_x0 = r/r0. The variable names are kept as
    % close to the original reference as possible so that it is easier to 
    % compare them directly 
	
	x_x0 = r0/r;
	x0_x = r/r0;

	if x_x0 == 1
		i_A = cos(beta_i);
		i_T = sin(beta_i);
	else
		p = 1+(x_x0^2/tan(beta_i)^2);
		u = exp(Z*(log((p^0.5-1)*(1/sin(beta_i)-1)^(-1)*x0_x)+p^0.5-1/sin(beta_i)));    
		g = (sin(beta_i))^3*(2+9/(tan(beta_i)^2))+(3*p-5)*p^(-3/2);
		f = sin(beta_i)^(-0.5)*p^(-0.25);

		if x_x0 > 1
			A = f*(1/(u-1)-(g/(24*Z))*log(u/(u-1)));

			i_A = (x_x0-1)*Z*A/tan(beta_i);
			i_T = (1-x0_x)*Z*(1+A);
		else
			B = f*(u/(1-u)+(g/(24*Z))*log(1/(1-u)));

			i_A = (1-x_x0)*Z*(1+B)/tan(beta_i);
			i_T = (x0_x-1)*Z*B;
		end
	end
end