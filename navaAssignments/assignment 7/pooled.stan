data {
    int<lower=0> N; // Numnber of observations per machine
    int<lower=0> J; // Number of machines
    vector[J] y[N]; // This seems to create a matrix
    vector[J*N] ypool; // pooled ys
}

parameters {
    real mu;              
    real<lower=0> sigma; 
}

model {
    // Priors
    mu ~ normal(0,1);
    sigma ~ normal(0,10);

    // Likelihood
    ypool ~ normal(mu, sigma);
}

generated quantities {
   real ypred6;
   real ypred5;
   real ypred7;
// Compute predictive distribution
// for the sixth machine
   ypred6 = normal_rng(mu, sigma);
// for the fifth machine
   ypred5 = normal_rng(mu, sigma);
// for the seventh machine
   ypred7 = normal_rng(mu, sigma);
}
