% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FitDynamicGrowthMCMC_class.R
\name{FitDynamicGrowthMCMC}
\alias{FitDynamicGrowthMCMC}
\alias{plot.FitDynamicGrowthMCMC}
\alias{summary.FitDynamicGrowthMCMC}
\alias{residuals.FitDynamicGrowthMCMC}
\alias{coef.FitDynamicGrowthMCMC}
\alias{vcov.FitDynamicGrowthMCMC}
\alias{deviance.FitDynamicGrowthMCMC}
\alias{fitted.FitDynamicGrowthMCMC}
\alias{predict.FitDynamicGrowthMCMC}
\title{FitDynamicGrowthMCMC class}
\usage{
\method{plot}{FitDynamicGrowthMCMC}(
  x,
  y = NULL,
  ...,
  add_factor = NULL,
  ylims = NULL,
  label_y1 = "logN",
  label_y2 = add_factor,
  line_col = "black",
  line_size = 1,
  line_type = 1,
  point_col = "black",
  point_size = 3,
  point_shape = 16,
  line_col2 = "black",
  line_size2 = 1,
  line_type2 = "dashed"
)

\method{summary}{FitDynamicGrowthMCMC}(object, ...)

\method{residuals}{FitDynamicGrowthMCMC}(object, ...)

\method{coef}{FitDynamicGrowthMCMC}(object, ...)

\method{vcov}{FitDynamicGrowthMCMC}(object, ...)

\method{deviance}{FitDynamicGrowthMCMC}(object, ...)

\method{fitted}{FitDynamicGrowthMCMC}(object, ...)

\method{predict}{FitDynamicGrowthMCMC}(object, times = NULL, newdata = NULL, ...)
}
\arguments{
\item{x}{The object of class \code{FitDynamicGrowthMCMC} to plot.}

\item{y}{ignored}

\item{...}{ignored}

\item{add_factor}{whether to plot also one environmental factor.
If \code{NULL} (default), no environmenta factor is plotted. If set
to one character string that matches one entry of x$env_conditions,
that condition is plotted in the secondary axis}

\item{ylims}{A two dimensional vector with the limits of the primary y-axis.}

\item{label_y1}{Label of the primary y-axis.}

\item{label_y2}{Label of the secondary y-axis.}

\item{line_col}{Aesthetic parameter to change the colour of the line geom in the plot, see: \code{\link{geom_line}}}

\item{line_size}{Aesthetic parameter to change the thickness of the line geom in the plot, see: \code{\link{geom_line}}}

\item{line_type}{Aesthetic parameter to change the type of the line geom in the plot, takes numbers (1-6) or strings ("solid") see: \code{\link{geom_line}}}

\item{point_col}{Aesthetic parameter to change the colour of the point geom, see: \code{\link{geom_point}}}

\item{point_size}{Aesthetic parameter to change the size of the point geom, see: \code{\link{geom_point}}}

\item{point_shape}{Aesthetic parameter to change the shape of the point geom, see: \code{\link{geom_point}}}

\item{line_col2}{Same as lin_col, but for the environmental factor.}

\item{line_size2}{Same as line_size, but for the environmental factor.}

\item{line_type2}{Same as lin_type, but for the environmental factor.}

\item{object}{an instance of \code{FitDynamicGrowthMCMC}.}

\item{times}{A numeric vector with the time points for the simulations. \code{NULL}
by default (using the same time points as those for the simulation).}

\item{newdata}{a tibble describing the environmental conditions (as \code{env_conditions})
in \code{\link{predict_dynamic_growth}}. 
If \code{NULL} (default), uses the same conditions as those for fitting.}
}
\description{
The \code{FitDynamicGrowthMCMC} a model fitted based on a dynamic growth experiment
using an MCMC algorithm. Its constructor is \code{\link{fit_MCMC_growth}}.

It is a subclass of list with the items:
     \itemize{
         \item fit_results: the object returned by \code{modMCMC}.
         \item best_prediction: the model prediction for the fitted parameters.
         \item env_conditions: environmental conditions for the fit.
         \item data: data used for the fit.
         \item starting: starting values for model fitting
         \item known: parameter values set as known.
         \item sec_models: a named vector with the secondary model
         for each environmental factor
         }
}
\section{Functions}{
\itemize{
\item \code{plot.FitDynamicGrowthMCMC}: compares the model fitted against the data.

\item \code{summary.FitDynamicGrowthMCMC}: statistical summary of the fit.

\item \code{residuals.FitDynamicGrowthMCMC}: model residuals.

\item \code{coef.FitDynamicGrowthMCMC}: vector of fitted model parameters.

\item \code{vcov.FitDynamicGrowthMCMC}: variance-covariance matrix of the model,
estimated as the variance of the samples from the Markov chain.

\item \code{deviance.FitDynamicGrowthMCMC}: deviance of the model, calculated as the sum
of squared residuals for the parameter values resulting in the best fit.

\item \code{fitted.FitDynamicGrowthMCMC}: vector of fitted values.

\item \code{predict.FitDynamicGrowthMCMC}: vector of model predictions.
}}

