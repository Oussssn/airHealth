#' Calculate Health Impact Score
#'
#' This function tries to figure out how bad the air quality is for your health.
#' I used some basic rules from the WHO, but it's pretty simple!
#'
#' @param aqi Air Quality Index values
#' @return A data frame with health impact scores and warnings
#' @export
calculate_health_impact <- function(aqi) {
  # Make sure we have valid AQI numbers
  if (!is.numeric(aqi)) {
    stop("AQI values must be numeric")
  }
  
  # Calculate how bad it is for your health (0-100 scale)
  impact_score <- cut(aqi,
                     breaks = c(0, 50, 100, 150, 200, 300, Inf),
                     labels = c(20, 40, 60, 80, 90, 100),
                     right = FALSE)
  
  # Convert to numbers
  impact_score <- as.numeric(as.character(impact_score))
  
  # Figure out what warning to give
  warning <- cut(aqi,
                breaks = c(0, 50, 100, 150, 200, 300, Inf),
                labels = c(
                  "Air quality is good! You can go outside and play!",
                  "Air quality is okay, but sensitive people might feel bad",
                  "Not great for people with asthma or heart problems",
                  "Everyone should be careful, especially kids and old people",
                  "Really bad air! Stay inside if you can!",
                  "DANGER! The air is super bad! Stay inside!"
                ),
                right = FALSE)
  
  # Return everything in a nice data frame
  return(data.frame(
    AQI = aqi,
    Health_Impact_Score = impact_score,
    Warning = warning
  ))
}

#' Calculate Daily Health Risk
#'
#' This function looks at air quality over time and tries to guess
#' if it might make people sick. It's not perfect, but it's a start!
#'
#' @param aqi_data A data frame with AQI values over time
#' @param days Number of days to look at (default is 7)
#' @return A data frame with daily risk scores
#' @export
calculate_daily_risk <- function(aqi_data, days = 7) {
  # Check if we have the right data
  if (!is.data.frame(aqi_data) || !"AQI" %in% names(aqi_data)) {
    stop("Input must be a data frame with an AQI column")
  }
  
  # Get the last 'days' days of data
  recent_data <- tail(aqi_data, days)
  
  # Calculate average AQI
  avg_aqi <- mean(recent_data$AQI, na.rm = TRUE)
  
  # Calculate risk score (0-100)
  risk_score <- cut(avg_aqi,
                   breaks = c(0, 50, 100, 150, 200, 300, Inf),
                   labels = c(10, 30, 50, 70, 85, 100),
                   right = FALSE)
  
  # Convert to numbers
  risk_score <- as.numeric(as.character(risk_score))
  
  # Figure out what to tell people
  risk_level <- cut(avg_aqi,
                   breaks = c(0, 50, 100, 150, 200, 300, Inf),
                   labels = c(
                     "Low risk - Air is pretty clean!",
                     "Moderate risk - Some people might feel bad",
                     "High risk - Lots of people might feel bad",
                     "Very high risk - Most people should stay inside",
                     "Extreme risk - Everyone should stay inside!",
                     "DANGER! Air is super bad!"
                   ),
                   right = FALSE)
  
  # Return everything in a nice data frame
  return(data.frame(
    Average_AQI = avg_aqi,
    Risk_Score = risk_score,
    Risk_Level = risk_level
  ))
}

#' Estimate Respiratory Health Effects
#'
#' This function tries to estimate how air pollution might affect people's breathing.
#' It's a simplified model based on basic health research.
#'
#' @param pm25 PM2.5 concentration
#' @param pm10 PM10 concentration
#' @param population Numeric vector of population counts
#' @return A data frame containing estimated respiratory health effects
#' @export
estimate_respiratory_effects <- function(pm25, pm10, population) {
  # Input validation
  if (!all(is.numeric(c(pm25, pm10, population)))) {
    stop("All inputs must be numeric")
  }
  
  # Calculate relative risks (simplified model)
  rr_pm25 <- 1 + (pm25 / 100) * 0.1
  rr_pm10 <- 1 + (pm10 / 100) * 0.05
  
  # Calculate attributable fraction
  af_pm25 <- (rr_pm25 - 1) / rr_pm25
  af_pm10 <- (rr_pm10 - 1) / rr_pm10
  
  # Calculate estimated cases (simplified model)
  baseline_rate <- 0.1  # 10% baseline respiratory disease rate
  cases_pm25 <- population * baseline_rate * af_pm25
  cases_pm10 <- population * baseline_rate * af_pm10
  
  return(data.frame(
    PM2.5_Relative_Risk = rr_pm25,
    PM10_Relative_Risk = rr_pm10,
    PM2.5_Attributable_Fraction = af_pm25,
    PM10_Attributable_Fraction = af_pm10,
    Estimated_PM2.5_Cases = cases_pm25,
    Estimated_PM10_Cases = cases_pm10
  ))
} 