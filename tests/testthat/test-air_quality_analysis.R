library(testthat)
library(airHealth)

test_that("calculate_aqi works correctly", {
  # Test with valid inputs
  pm25 <- c(12, 35, 55, 150, 250)
  pm10 <- c(54, 154, 254, 354, 424)
  o3 <- c(54, 70, 85, 105, 200)
  no2 <- c(53, 100, 360, 649, 1249)
  
  result <- calculate_aqi(pm25, pm10, o3, no2)
  
  # Check structure
  expect_is(result, "data.frame")
  expect_true(all(c("AQI", "Category") %in% names(result)))
  
  # Check values
  expect_true(all(result$AQI >= 0))
  expect_true(all(result$AQI <= 500))
  
  # Test with invalid inputs
  expect_error(calculate_aqi("invalid", pm10, o3, no2))
  expect_error(calculate_aqi(pm25, "invalid", o3, no2))
})

test_that("calculate_health_impact works correctly", {
  # Create test data
  aqi_data <- data.frame(
    AQI = c(50, 100, 150, 200, 300),
    Category = c("Good", "Moderate", "Unhealthy for Sensitive Groups",
                "Unhealthy", "Very Unhealthy")
  )
  population <- 100000
  exposure_hours <- 24
  
  result <- calculate_health_impact(aqi_data, population, exposure_hours)
  
  # Check structure
  expect_is(result, "data.frame")
  expect_true(all(c("Health_Impact_Score", "Risk_Level") %in% names(result)))
  
  # Check values
  expect_true(all(result$Health_Impact_Score >= 0))
  expect_true(all(result$Population == population))
  expect_true(all(result$Exposure_Hours == exposure_hours))
  
  # Test with invalid inputs
  expect_error(calculate_health_impact("invalid", population, exposure_hours))
  expect_error(calculate_health_impact(aqi_data, "invalid", exposure_hours))
})

test_that("estimate_respiratory_effects works correctly", {
  # Test with valid inputs
  pm25 <- c(12, 35, 55, 150, 250)
  pm10 <- c(54, 154, 254, 354, 424)
  population <- 100000
  
  result <- estimate_respiratory_effects(pm25, pm10, population)
  
  # Check structure
  expect_is(result, "data.frame")
  expect_true(all(c("PM2.5_Relative_Risk", "PM10_Relative_Risk",
                   "PM2.5_Attributable_Fraction", "PM10_Attributable_Fraction",
                   "Estimated_PM2.5_Cases", "Estimated_PM10_Cases") %in% names(result)))
  
  # Check values
  expect_true(all(result$PM2.5_Relative_Risk >= 1))
  expect_true(all(result$PM10_Relative_Risk >= 1))
  expect_true(all(result$Estimated_PM2.5_Cases >= 0))
  expect_true(all(result$Estimated_PM10_Cases >= 0))
  
  # Test with invalid inputs
  expect_error(estimate_respiratory_effects("invalid", pm10, population))
  expect_error(estimate_respiratory_effects(pm25, "invalid", population))
}) 