function F = funcLikelihood(a)
load('likelihood.mat');
F(1) = diff(likelihood, a(1));
F(2) = diff(likelihood, a(2));
end
