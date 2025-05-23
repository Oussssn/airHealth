% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/health_impact.R
\name{estimate_respiratory_effects}
\alias{estimate_respiratory_effects}
\title{Estimate Respiratory Health Effects}
\usage{
estimate_respiratory_effects(pm25, pm10, population)
}
\arguments{
\item{pm25}{PM2.5 concentration}

\item{pm10}{PM10 concentration}

\item{population}{Numeric vector of population counts}
}
\value{
A data frame containing estimated respiratory health effects
}
\description{
This function tries to estimate how air pollution might affect people's breathing.
It's a simplified model based on basic health research.
}
