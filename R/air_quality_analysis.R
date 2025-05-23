#' Calculate Air Quality Index (AQI)
#'
#' This is my first attempt at calculating AQI! I used the EPA's method
#' but made it simpler to understand. It's not perfect, but it works!
#'
#' @param pm25 PM2.5 measurements (the tiny particles)
#' @param pm10 PM10 measurements (the bigger particles)
#' @param o3 Ozone measurements
#' @param no2 Nitrogen dioxide measurements
#' @return A data frame with AQI scores and what they mean
#' @export
calculate_aqi <- function(pm25, pm10, o3, no2) {
  # Check if the numbers make sense
  if (!all(is.numeric(c(pm25, pm10, o3, no2)))) {
    stop("All inputs must be numeric values")
  }
  
  # Calculate scores for each type of pollution
  pm25_score <- calculate_pm25_index(pm25)
  pm10_score <- calculate_pm10_index(pm10)
  o3_score <- calculate_o3_index(o3)
  no2_score <- calculate_no2_index(no2)
  
  # The overall AQI is the worst one (that's how EPA does it!)
  aqi <- pmax(pm25_score, pm10_score, o3_score, no2_score, na.rm = TRUE)
  
  # Figure out what the score means
  category <- cut(aqi,
                 breaks = c(0, 50, 100, 150, 200, 300, Inf),
                 labels = c("Good", "Moderate", "Unhealthy for Sensitive Groups",
                           "Unhealthy", "Very Unhealthy", "Hazardous"),
                 right = FALSE)
  
  # Return everything in a nice data frame
  return(data.frame(
    AQI = aqi,
    Category = category,
    PM2.5_Score = pm25_score,
    PM10_Score = pm10_score,
    O3_Score = o3_score,
    NO2_Score = no2_score
  ))
}

#' Calculate PM2.5 score
#' @param pm25 PM2.5 measurements
#' @return PM2.5 score (0-300)
#' @keywords internal
calculate_pm25_index <- function(pm25) {
  # These are the EPA breakpoints I found online
  breaks <- c(0, 12, 35.4, 55.4, 150.4, 250.4, Inf)
  values <- c(0, 50, 100, 150, 200, 300)
  
  # Helper function to find the right score
  find_score <- function(x) {
    if (is.na(x)) return(NA)
    idx <- findInterval(x, breaks)
    if (idx == 0 || idx > length(values)) return(NA)
    return(values[idx])
  }
  
  return(sapply(pm25, find_score))
}

#' Calculate PM10 score
#' @param pm10 PM10 measurements
#' @return PM10 score (0-300)
#' @keywords internal
calculate_pm10_index <- function(pm10) {
  # EPA breakpoints for PM10
  breaks <- c(0, 54, 154, 254, 354, 424, Inf)
  values <- c(0, 50, 100, 150, 200, 300)
  
  find_score <- function(x) {
    if (is.na(x)) return(NA)
    idx <- findInterval(x, breaks)
    if (idx == 0 || idx > length(values)) return(NA)
    return(values[idx])
  }
  
  return(sapply(pm10, find_score))
}

#' Calculate O3 score
#' @param o3 Ozone measurements
#' @return O3 score (0-300)
#' @keywords internal
calculate_o3_index <- function(o3) {
  # EPA breakpoints for ozone
  breaks <- c(0, 54, 70, 85, 105, 200, Inf)
  values <- c(0, 50, 100, 150, 200, 300)
  
  find_score <- function(x) {
    if (is.na(x)) return(NA)
    idx <- findInterval(x, breaks)
    if (idx == 0 || idx > length(values)) return(NA)
    return(values[idx])
  }
  
  return(sapply(o3, find_score))
}

#' Calculate NO2 score
#' @param no2 Nitrogen dioxide measurements
#' @return NO2 score (0-300)
#' @keywords internal
calculate_no2_index <- function(no2) {
  # EPA breakpoints for NO2
  breaks <- c(0, 53, 100, 360, 649, 1249, Inf)
  values <- c(0, 50, 100, 150, 200, 300)
  
  find_score <- function(x) {
    if (is.na(x)) return(NA)
    idx <- findInterval(x, breaks)
    if (idx == 0 || idx > length(values)) return(NA)
    return(values[idx])
  }
  
  return(sapply(no2, find_score))
} 