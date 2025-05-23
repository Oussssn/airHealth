# Create sample air quality data
set.seed(123)
n_days <- 365

# Generate dates
dates <- seq.Date(from = as.Date("2023-01-01"), by = "day", length.out = n_days)

# Generate pollutant data with realistic patterns
# PM2.5 (µg/m³)
pm25 <- rnorm(n_days, mean = 15, sd = 5) + 
        sin(seq(0, 4*pi, length.out = n_days)) * 5 +
        rnorm(n_days, mean = 0, sd = 2)
pm25 <- pmax(0, pm25)  # Ensure non-negative values

# PM10 (µg/m³)
pm10 <- pm25 * 2 + rnorm(n_days, mean = 10, sd = 3)

# O3 (ppb)
o3 <- rnorm(n_days, mean = 40, sd = 10) + 
      sin(seq(0, 4*pi, length.out = n_days)) * 15 +
      rnorm(n_days, mean = 0, sd = 5)
o3 <- pmax(0, o3)

# NO2 (ppb)
no2 <- rnorm(n_days, mean = 30, sd = 8) + 
       cos(seq(0, 4*pi, length.out = n_days)) * 10 +
       rnorm(n_days, mean = 0, sd = 3)
no2 <- pmax(0, no2)

# Create data frame
air_quality_data <- data.frame(
  date = dates,
  PM2.5 = pm25,
  PM10 = pm10,
  O3 = o3,
  NO2 = no2
)

# Save as R data file
usethis::use_data(air_quality_data, overwrite = TRUE) 