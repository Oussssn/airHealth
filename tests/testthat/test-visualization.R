library(testthat)
library(airHealth)

test_that("plot_aqi_trend works correctly", {
  # Create test data
  aqi_data <- data.frame(
    date = seq.Date(from = as.Date("2024-01-01"), by = "day", length.out = 10),
    AQI = c(50, 100, 150, 200, 300, 250, 200, 150, 100, 50)
  )
  
  # Test plot creation
  p <- plot_aqi_trend(aqi_data, "date")
  
  # Check plot object
  expect_is(p, "ggplot")
  
  # Test with invalid inputs
  expect_error(plot_aqi_trend("invalid", "date"))
  expect_error(plot_aqi_trend(aqi_data, "nonexistent_column"))
})

test_that("plot_health_impact works correctly", {
  # Create test data
  health_data <- data.frame(
    Category = c("Low", "Moderate", "High", "Very High", "Extreme"),
    Health_Impact_Score = c(500, 2500, 7500, 25000, 75000)
  )
  
  # Test plot creation
  p <- plot_health_impact(health_data, "Category")
  
  # Check plot object
  expect_is(p, "ggplot")
  
  # Test with invalid inputs
  expect_error(plot_health_impact("invalid", "Category"))
  expect_error(plot_health_impact(health_data, "nonexistent_column"))
})

test_that("plot_correlation_heatmap works correctly", {
  # Create test data
  set.seed(123)
  data <- data.frame(
    PM2.5 = rnorm(100),
    PM10 = rnorm(100),
    O3 = rnorm(100),
    NO2 = rnorm(100),
    Health_Score = rnorm(100)
  )
  
  # Test plot creation
  p <- plot_correlation_heatmap(data)
  
  # Check plot object
  expect_is(p, "ggplot")
  
  # Test with invalid inputs
  expect_error(plot_correlation_heatmap("invalid"))
  expect_error(plot_correlation_heatmap(data.frame()))
}) 