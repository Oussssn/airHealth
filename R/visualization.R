#' Plot Air Quality Trends
#'
#' This function makes a graph of how air quality changes over time.
#' I used ggplot2 because it makes nice-looking plots!
#'
#' @param aqi_data A data frame with dates and AQI values
#' @param pollutant Which pollutant to plot (default is "AQI")
#' @return A ggplot object showing the trend
#' @export
plot_aqi_trend <- function(aqi_data, pollutant = "AQI") {
  # Check if we have the right data
  if (!is.data.frame(aqi_data)) {
    stop("Input must be a data frame with dates and AQI values")
  }
  
  # Make sure we have a date column
  if (!"date" %in% names(aqi_data)) {
    stop("Data must contain a 'date' column")
  }
  
  # Make sure we have the pollutant we want to plot
  if (!pollutant %in% names(aqi_data)) {
    stop("Specified pollutant not found in data")
  }
  
  # Make the plot
  p <- ggplot2::ggplot(aqi_data, ggplot2::aes(x = date, y = .data[[pollutant]])) +
    ggplot2::geom_line(color = "blue", size = 1) +
    ggplot2::geom_point(color = "darkblue", size = 2) +
    ggplot2::labs(
      title = paste("How", pollutant, "Changes Over Time"),
      x = "Date",
      y = pollutant
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 16, face = "bold"),
      axis.title = ggplot2::element_text(size = 12),
      axis.text = ggplot2::element_text(size = 10)
    )
  
  return(p)
}

#' Plot Health Impact
#'
#' This function makes a bar chart showing how bad the air quality is
#' for your health. The colors show how serious it is!
#'
#' @param health_data A data frame with health impact scores
#' @return A ggplot object showing the health impact
#' @export
plot_health_impact <- function(health_data) {
  # Check if we have the right data
  if (!is.data.frame(health_data)) {
    stop("Input must be a data frame with health impact scores")
  }
  
  # Make sure we have the right columns
  if (!"Health_Impact_Score" %in% names(health_data)) {
    stop("Data must contain a 'Health_Impact_Score' column")
  }
  
  # Make the plot
  p <- ggplot2::ggplot(health_data, ggplot2::aes(x = 1, y = Health_Impact_Score)) +
    ggplot2::geom_bar(stat = "identity", fill = "red") +
    ggplot2::coord_cartesian(ylim = c(0, 100)) +
    ggplot2::labs(
      title = "How Bad is the Air for Your Health?",
      x = "",
      y = "Health Impact Score (0-100)"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 16, face = "bold"),
      axis.title = ggplot2::element_text(size = 12),
      axis.text = ggplot2::element_text(size = 10)
    )
  
  return(p)
}

#' Plot Daily Risk
#'
#' This function makes a line plot showing how risky the air quality
#' is over time. The higher the line, the worse it is!
#'
#' @param risk_data A data frame with daily risk scores
#' @return A ggplot object showing the daily risk
#' @export
plot_daily_risk <- function(risk_data) {
  # Check if we have the right data
  if (!is.data.frame(risk_data)) {
    stop("Input must be a data frame with risk scores")
  }
  
  # Make sure we have the right columns
  if (!"Risk_Score" %in% names(risk_data)) {
    stop("Data must contain a 'Risk_Score' column")
  }
  
  # Make the plot
  p <- ggplot2::ggplot(risk_data, ggplot2::aes(x = 1:length(Risk_Score), y = Risk_Score)) +
    ggplot2::geom_line(color = "orange", size = 1) +
    ggplot2::geom_point(color = "red", size = 2) +
    ggplot2::coord_cartesian(ylim = c(0, 100)) +
    ggplot2::labs(
      title = "How Risky is the Air Quality?",
      x = "Days",
      y = "Risk Score (0-100)"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      plot.title = ggplot2::element_text(size = 16, face = "bold"),
      axis.title = ggplot2::element_text(size = 12),
      axis.text = ggplot2::element_text(size = 10)
    )
  
  return(p)
}

#' Create Correlation Heatmap
#'
#' This function makes a heatmap showing how different air quality
#' measurements relate to each other. It's pretty cool!
#'
#' @param data Data frame containing air quality and health metrics
#' @param title Plot title (optional)
#' @return A ggplot object showing correlation heatmap
#' @export
plot_correlation_heatmap <- function(data, title = "Air Quality and Health Metrics Correlation") {
  # Input validation
  if (!is.data.frame(data)) {
    stop("Input must be a data frame")
  }
  
  # Calculate correlation matrix
  cor_matrix <- stats::cor(data, use = "pairwise.complete.obs")
  
  # Convert to long format for plotting
  cor_data <- as.data.frame(cor_matrix) %>%
    tibble::rownames_to_column("Var1") %>%
    tidyr::pivot_longer(
      cols = -Var1,
      names_to = "Var2",
      values_to = "correlation"
    )
  
  # Create the plot
  p <- ggplot2::ggplot(cor_data, 
                      ggplot2::aes(x = Var1, y = Var2, fill = correlation)) +
    ggplot2::geom_tile() +
    ggplot2::scale_fill_gradient2(
      low = "blue",
      high = "red",
      mid = "white",
      midpoint = 0,
      limit = c(-1, 1)
    ) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = title,
      x = "",
      y = ""
    ) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(hjust = 0.5),
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)
    )
  
  return(p)
} 