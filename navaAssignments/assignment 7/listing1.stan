// The corrected
data {
    int<lower=0> N;     // number of observations
    vector[N] x;        // observations per year
    vector[N] y;        // observation number of drowned
    real xpred;         // prediction year --- ERROR 3: See below
}
parameters {
    real alpha;
    real beta;
    real<lower=0> sigma;    // ERROR 1: sigma must be > 0
}
transformed parameters {
    vector[N] mu = alpha + beta*x;
}
model {
    // Priors
    beta ~ normal(0, 25);

    // Likelihood function
    y ~ normal(mu, sigma);   // ERROR 2: line not ending in ";"
}
generated quantities {
   // ERROR 3: mu was not using xpred
   real ypred = normal_rng(alpha + beta*xpred, sigma); 
}