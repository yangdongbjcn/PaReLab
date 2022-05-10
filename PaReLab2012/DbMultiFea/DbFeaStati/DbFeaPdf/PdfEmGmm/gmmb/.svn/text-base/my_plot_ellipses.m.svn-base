%GMMB_FJ     - Figueiredo-Jain estimated GMM parameters
% Produces a bayesS struct without 'apriories'.
%
% Works with complex numbers directly.
%
% estimate = GMMB_FJ(data[, parameters])
% [estimate, stats] = GMMB_FJ(...)
%
% Parameters (default):
%   maxloops	maximum number of loops per a CEM run (500)
%   Cmax	the maximum number of GMM components
%		set to -1 to use all data points as component means
%   Cmin	the minimum number of GMM components tried (1)
%   verbose	print some progress numbers (false)
%   thr		CEM2 threshold, relative loglikelihood change (1e-6)
%   animate	plot data and ellipses as the algorithm runs (false)
%   covtype	Covariance matrix structure: 1=diagonal, other=free (0)
%   broken	With complex data, calculate no. of component parameters
%		as with real data (true).
% At least Cmax should be set explicitly.
% Example:
%   estS = gmmb_fj(data, 'Cmax', 50, 'thr', 1e-9)
%
% References:
%   [1] Duda, R.O., Hart, P.E, Stork, D.G, Pattern Classification,
%   2nd ed., John Wiley & Sons, Inc., 2001.
%   [2] Bilmes, J.A., A Gentle Tutorial of the EM Algorithm and its
%    Application to Parameter Estimation for Gaussian Mixture and Hidden
%    Markov Models
%   International Computer Science Institute, 1998
%   [3] Figueiredo, M.A.T., Jain, A.K., Unsupervised Learning on
%    Finite Mixture Models, IEEE transactions of pattern analysis and
%    machine intelligence, vol.24, no3, March 2002
%
% This code is directly based on [3] and code published on
% Figueiredo homepage: http://www.lx.it.pt/~mtf/
%
% Author(s):
%    Pekka Paalanen <pekka.paalanen@lut.fi>
%
% Copyright:
%
%   Bayesian Classifier with Gaussian Mixture Model Pdf
%   functionality is Copyright (C) 2003 by Pekka Paalanen and
%   Joni-Kristian Kamarainen.
%
%   $Name:  $ $Revision: 1.2 $  $Date: 2004/11/02 09:00:18 $
%
%
% Logging
%   parameters
%
%      logging   What kind of logging to do:
%        0 - no logging
%        1 - normal logging
%        2 - extra logging: store all intermediate mixtures
%      If the 'stats' output parameter is defined, then 'logging'
%      defaults to 1, otherwise it is forced to 0.
%
%  the 'stats' struct:
%      iterations: CEM (full) iteration count
%      costs:      iterations long vector of the cost value
%      annihilations: component annihilation log [annih, deletion]*iters
%      covfixer2:  iterations-by-C matrix of gmmb_covfixer fix round counts
%      loglikes:   iterations long vector of the log-likelihood
%    extra logging:
%      initialmix: parameters for the initial mixture
%      mixtures:   parameters for all intermediate mixtures

function my_plot_ellipses(data, mu, sigma, weight)

h = my_plot_init();

dtime = 0.3;

D = size(mu, 1);

if D ~= 2
	error('Can plot only 2D objects.');
end

[x,y,z] = cylinder([2 2], 40);
xy = [ x(1,:) ; y(1,:) ];

figure(h);

plot(data(:,1), data(:,2), 'rx');

hold on
C = size(mu, 2);
for c = 1:C
	mxy = chol(sigma(:,:,c))' * xy;
	x = mxy(1,:) + mu(1,c);
	y = mxy(2,:) + mu(2,c);
	z = ones(size(x))*weight(c);
	plot3(x,y,z, 'k-');
end
drawnow;
hold off

t = toc;
if t+0.01<dtime
	pause(dtime-t);
end
tic

end

function h = my_plot_init()
h = figure;
figure(h);
% title('Distribution of x_1 and x_2 values','FontSize',14);
% xlabel('x_1 value','FontSize',14);
% ylabel('x_2 value','FontSize',14);
% zlabel('weight','FontSize',14);
view(2)
tic;
end