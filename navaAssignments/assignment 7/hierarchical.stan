data {
    int<lower=0> N; // Numnber of observations per machine
    int<lower=0> J; // Number of machines
    vector[J] y[N]; // This seems to create a matrix
    vector[J*N] ypool; // pooled ys
}

parameters {
    vector[J+1] mu;      // Notice dimensions J+1 in order to get info on the seventh mu and get preds on the seventh machine             
    real<lower=0> sigma; 
// Hyper-parameter
    real<lower=0> tau;
}

model {
// Hyper-priors
    tau ~ normal(0,1);

// Priors
    for(j in 1:(J+1)) {
        mu[j] ~ normal(0,tau);
    }
    sigma ~ normal(0,10);

// Likelihood
    for(j in 1:J) {
        y[,j] ~ normal(mu[j], sigma);
    }
}

generated quantities {
   real ypred6;
   real ypred7;
// for the sixth machine
   ypred6 = normal_rng(mu[6], sigma);
// for the seventh machine
    ypred7 = normal_rng(mu[7], sigma);
}
