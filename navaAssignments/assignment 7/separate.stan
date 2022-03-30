data {
    int<lower=0> N; // Numnber of observations per machine
    int<lower=0> J; // Number of machines
    vector[J] y[N]; // This seems to create a matrix
    vector[J*N] ypool; // pooled ys
}

parameters {
    vector[J] mu;              
    vector<lower=0>[J] sigma; 
}

model {
    // Priors
    for(j in 1:J) {
        mu[j] ~ normal(0,1);
        sigma[j] ~ normal(0,10);
    }

    // Likelihood
    for(j in 1:J) {
        y[,j] ~ normal(mu[j], sigma[j]);
    }
}

generated quantities {
   real ypred6;
   real ypred5;
// Compute predictive distribution
// for the sixth machine
   ypred6 = normal_rng(mu[6], sigma[6]);
// for the fifth machine
   ypred5 = normal_rng(mu[5], sigma[5]);
}
