data {
    int<lower=0> N;    // Numnber of observations per machine
    int<lower=0> J;    // Number of machines
    vector[J] y[N];    // This seems to create a matrix
    vector[J*N] ypool; // pooled ys
}

parameters {
    vector[J] mu;              
    vector<lower=0>[J] sigma; 
}

model {
    // Priors
    for(j in 1:J) {
        mu[j] ~ normal(0,10);
        sigma[j] ~ gamma(1,1);
    }

    // Likelihood
    for(j in 1:J) {
        y[,j] ~ normal(mu[j], sigma[j]);
    }
}

generated quantities {
   real ypred;
// for the first machine
   ypred = normal_rng(mu[1], sigma[1]);
}