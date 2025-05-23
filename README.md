# airHealth: My First R Package! 🎓

**Student Information**  
Name: İbrahim Oğuz Asan  
Student ID: 2409111083  
Course: SWE005 - Multivariate Statistical Analysis with R

Hey there! 👋 I'm super excited to share my first R package with you! This project is part of my SWE005 - Multivariate Statistical Analysis with R course, where I learned how to create and publish R packages. I've put a lot of effort into making this package both useful and easy to understand.

## What's This All About?

This package helps you analyze air quality data and understand its impact on health. It's perfect for:
- Calculating air quality scores
- Understanding health risks
- Creating cool visualizations
- Learning about air pollution

## What Can It Do?

### 1. Air Quality Analysis
- Calculate Air Quality Index (AQI)
- Analyze different pollutants
- Get clear air quality categories

### 2. Health Impact Assessment
- Evaluate health effects
- Calculate short-term risks
- Estimate respiratory impacts

### 3. Visualization Tools
- Create time series plots
- Show health impact trends
- Generate correlation heatmaps

## How to Install

First, make sure you have the `devtools` package:
```R
install.packages("devtools")
```

Then install my package:
```R
devtools::install_github("yourusername/airHealth")
```

## Quick Start

Here's how to use some of the main features:

```R
# Calculate air quality score
result <- calculate_aqi(pm25 = 12, pm10 = 35, o3 = 45, no2 = 30)
print(result)

# Check health impacts
health_risk <- calculate_health_impact(aqi = result$aqi)
print(health_risk)

# Create a visualization
plot_aqi_trend(data = my_data)
```

## Want to Help?

I'm still learning, so any feedback or suggestions are super welcome! Feel free to:
- Report bugs
- Suggest improvements
- Share your ideas
- Help with documentation

## Where I Got My Info

I used these sources to make sure everything is accurate:
- EPA Air Quality Index Guide
- WHO Health Guidelines
- R Package Development Best Practices

## My Learning Journey

This project taught me so much about:
- R package development
- Air quality analysis
- Health impact assessment
- Data visualization
- Documentation best practices

## Contact

Feel free to reach out to me at 210527007@stu.istinye.edu.tr if you have any questions or suggestions!

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

*This package was developed as part of the SWE005 - Multivariate Statistical Analysis with R course project.* 