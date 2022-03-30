data {
    int<lower=0> N; // Numnber of observations per machine
    int<lower=0> J; // Number of machines
    vector[J] y[N]; // This seems to create a matrix 
}

parameters {
    vector[J] mu;              // J parameters of location
    vector<lower=0>[J] sigma;  // J parameters of shape
}

model {
    // Priors
    for (j in 1:J) {
        mu[j] ~ normal(0,1);             // Weakly informative prior
        sigma[j] ~ inv_chi_square(10);   // Weakly informative prior
    }

    // Likelihood
    for (j in 1:J) {
        y[,j] ~ normal(mu[j], sigma[j]); // This seems to grab each of the j columns
    }
}

generated quantities {
   real ypred;
   // Compute predictive distribution
   // for the first machine
   ypred = normal_rng(mu[1], sigma[1]);
}
