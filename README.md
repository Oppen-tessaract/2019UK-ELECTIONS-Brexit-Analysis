# Brexit, Unemployment, and Conservative Vote Share in the 2019 UK General Election

## Overview
This project investigates whether Brexit support and unemployment were key factors behind the Conservative Party’s electoral success in the 2019 UK general election. Using constituency-level data from the British Election Study, the analysis tests the relationship between Conservative vote share, Leave vote share, and unemployment rate.

## Research Question
To what extent were Brexit advocacy and unemployment definitive factors behind the Conservative Party’s 2019 electoral success?

## Dataset
This analysis uses constituency-level data from the 2019 British Election Study (BES), combined with socio-economic and census information. The dataset includes 631 constituencies and variables measured at constituency level as percentage points.

## Variables
- `Con19`: Conservative vote share in 2019.
- `LeaveHanretty`: Estimated Leave vote share in 2016.
- `C11Unemployed`: Unemployment rate from the 2011 Census.

## Method
The project uses quantitative constituency-level analysis and linear regression to test the relationship between the Conservative vote share and two explanatory variables: Brexit support and unemployment. Two models were estimated:
- Model 1: Conservative vote share explained by Brexit support.
- Model 2: Conservative vote share explained by Brexit support and unemployment.

## Key Findings
- Brexit support had a positive and statistically significant relationship with Conservative vote share.
- In Model 1, a one percentage point increase in Brexit support was associated with an increase of about 0.878 percentage points in Conservative vote share.
- In Model 2, the Brexit coefficient increased to 0.945 after controlling for unemployment.
- Unemployment was also statistically significant, but the relationship was negative rather than positive.
- Model 2 explained 72.1% of the variance in Conservative vote share, compared with 36.1% in Model 1.

## Conclusion
The findings suggest that Brexit support was a strong positive predictor of Conservative vote share in 2019, while unemployment also played a statistically significant role in the model. The second model provided a much better fit than the first, indicating that both political and economic factors helped explain the Conservative Party’s electoral success.

## Repository Contents
- `README.md` — project overview and summary of findings.
- `report.pdf` — polished analysis report.
- `code/` — analysis scripts and regression code.

## Notes
This project is based on constituency-level analysis, so the findings should not be interpreted as individual voter behaviour. The unemployment measure is drawn from the 2011 Census, which means it may not fully reflect conditions in 2019.

## References
- British Election Study constituency data.
- Prosser (2020).
- Fieldhouse et al. (2022).
- Bossert et al. (2022).
- McNeil and Haberstroh (2022).
