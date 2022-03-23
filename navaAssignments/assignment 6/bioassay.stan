// Note:
// Script runs byoassay model in BDA v3 from Section 3.7
data { // Data is from Table 3.1
    int<lower=0> I;       // Number of groups
    int<lower=0> n;    // Number of animals
    real x[I];            // Doses
    int<lower=0,upper=n> y[I];    // Number of deaths
}
parameters {
    vector[2] theta;  // [alpha, beta]
}
model {
    row_vector[2] mu = [0,10];               // Location param
    matrix[2,2] sigma =[[4, 12],[12, 100]];  // Shape param
    vector[I] logLike;  // log-likelihood contribution per group

    // The prior distribution
    target += multi_normal_lpdf(theta | mu, sigma);
    
    // The log-likelihood term
    for(i in 1:I) {
        logLike[i] = binomial_logit_lpmf(y[i] | n, theta[1] + theta[2]*x[i]);
    }
    target += sum(logLike);
}
