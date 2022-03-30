data {
    int<lower=0> N; // Numnber of observations per machine
    int<lower=0> J; // Number of machines
    vector[J] y[N]; // This seems to create a matrix
    vector[J*N] ypool; // pooled ys
}

parameters {
    vector[J] mu;              
    real<lower=0> sigma;
// Hyper-parameter 
    real tauMu;
    real<lower=0> tauSigma; 
}

model {
// Hyper-priors
    tauMu ~ normal(0,10);
    tauSigma ~ gamma(1,1);

// Priors
    for(j in 1:J) {
        mu[j] ~ normal(tauMu, tauSigma);
    }
    sigma ~ normal(0,10);

// Likelihood
    for(j in 1:J) {
        y[,j] ~ normal(mu[j], sigma);
    }
}

generated quantities {
   real ypred;
   // Compute predictive distribution
   // for the first machine
   ypred = normal_rng(mu[1], sigma);
}
