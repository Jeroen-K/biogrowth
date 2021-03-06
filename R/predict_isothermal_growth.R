
#' Isothermal Baranyi model
#'
#' Baranyi growth model as defined by Baranyi and Roberts (1994). We use the solution
#' calculated by Poschet et al. (2005, doi: https://doi.org/10.1016/j.ijfoodmicro.2004.10.008)
#' after log-transformation according to MONTE CARLO ANALYSIS FOR MICROBIAL GROWTH CURVES,
#' by Oksuz and Buzrul.
#'
#' @param times Numeric vector of storage times
#' @param logN0 Initial log microbial count
#' @param mu Maximum specific growth rate (in ln CFU/[t])
#' @param lambda Lag phase duration
#' @param logNmax Maximum log microbial count
#'
#' @return Numeric vector with the predicted microbial count.
#'
iso_Baranyi <- function(times, logN0, mu, lambda, logNmax) {

    # mu <- mu/log(10)

    num <- 1 + exp(log(10)*mu*(times - lambda)) - exp(-log(10)*mu*lambda)
    den <- exp(log(10)*mu*(times-lambda)) - exp(-log(10)*mu*lambda) + 10^(logNmax - logN0)
    logN <- logNmax + log10(num/den)

    logN

}

#' Reparameterized Gompertz model
#'
#' Reparameterized Gompertz growth model defined by Zwietering et al. (1990).
#'
#' @inheritParams iso_Baranyi
#' @param C Difference between \code{logN0} and the maximum log-count.
#'
#' @return Numeric vector with the predicted microbial count.
#'
iso_repGompertz <- function(times, logN0, C, mu, lambda) {
    
    # mu <- mu/log(10)

    logN <- logN0 + C*(exp(-exp( exp(1)*(mu/C)*(lambda-times)+1 )))

    logN

}

#' Trilinear growth model
#'
#' Trilinear growth model defined by Buchanan et al. (1997).
#'
#' @inheritParams iso_Baranyi
#'
#' @return Numeric vector with the predicted microbial count.
#'
trilinear_model <- function(times, logN0, mu, lambda, logNmax) {
    
    # mu <- mu/log(10)

    logN <- logN0 + mu*(times - lambda)
    logN[times < lambda] <- logN0
    logN[logN>logNmax] <- logNmax

    logN


}

#' Logistic growth model
#' 
#' @inheritParams iso_repGompertz
#' 
#' @return Numeric vector with the predicted microbial count
#' 
logistic_model <- function(times, logN0, mu, lambda, C) {
    
    # mu <- mu/log(10)
    
    logN <- logN0 + C/(1 + exp(4*mu/C*(lambda-times) + 2))
    
    logN
}

#' Richards growth model
#' 
#' @inheritParams iso_repGompertz
#' @param nu Parameter describing the transition between growth phases
#' 
richards_model <- function(times, logN0, mu, lambda, C, nu) {
    
    # mu <- mu/log(10)
    
    exp_part <- 1 + nu + mu/C*(1+nu)^(1 + 1/nu)*(lambda-times)
    
    logN <- logN0 + C*(1 + nu*exp(exp_part))^(-1/nu)
    
    logN
    
}

#' Isothermal microbial growth
#'
#' Predicts population growth under static conditions using primary models.
#'
#' @param model_name Character defining the growth model.
#' @param times Numeric vector of storage times for the predictions.
#' @param model_pars Named vector or list defining the values of the model parameters.
#' @param check Whether to do basic checks (TRUE by default).
#'
#' @return An instance of \code{\link{IsothermalGrowth}}.
#'
#' @importFrom tibble tibble
#'
#' @export
#'
#' @examples
#' ## Define the simulations parameters
#'
#' my_model <- "modGompertz"
#' my_pars <- list(logN0 = 2, C = 6, mu = .2, lambda = 25)
#' my_time <- seq(0, 100, length = 1000)
#'
#' ## Do the simulation
#'
#' static_prediction <- predict_isothermal_growth(my_model, my_time, my_pars)
#'
#' ## Plot the results
#'
#' plot(static_prediction)
#'
#'
predict_isothermal_growth <- function(model_name, times, model_pars, check = TRUE) {

    ## Check the model parameters
    
    model_pars <- as.list(model_pars)

    if (isTRUE(check)) {

        check_primary_pars(model_name, model_pars)

    }

    ## Calculate the prediction

    logN <- switch(model_name,
           modGompertz = iso_repGompertz(times, model_pars$logN0, model_pars$C,
                                         model_pars$mu, model_pars$lambda),
           Baranyi = iso_Baranyi(times, model_pars$logN0, model_pars$mu,
                                 model_pars$lambda, model_pars$logNmax),
           Trilinear = trilinear_model(times, model_pars$logN0, model_pars$mu,
                                       model_pars$lambda,model_pars$logNmax),
           Logistic = logistic_model(times, model_pars$logN0, model_pars$mu,
                                     model_pars$lambda, model_pars$C),
           Richards = richards_model(times, model_pars$logN0, model_pars$mu,
                                     model_pars$lambda, model_pars$C,
                                     model_pars$nu),
           stop(paste("Unknown model:", model_name))
           )

    ## Prepare the output

    my_sim <- tibble(time = times, logN = logN)

    out <- list(simulation = my_sim,
                model = model_name,
                pars = model_pars
                )

    class(out) <- c("IsothermalGrowth", class(out))

    out

}








