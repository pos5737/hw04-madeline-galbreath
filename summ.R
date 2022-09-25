# integrate the tidyverse
library(tidyverse)

# read in the tidy dataset
df1 <- read_rds("data/manifesto_tidy.rds")

# group by party family
summ_df <- group_by (df1, party_fam)

# compute measures of location and scale
summ_df2 <- summarize(summ_df, average_vote = mean(percent_vote, na.rm = TRUE), 
            sd_vote = sd(percent_vote, na.rm = TRUE), 
            median_vote = median(percent_vote, na.rm = TRUE), 
            iqr_vote = IQR(percent_vote, na.rm = TRUE),
            average_milit_negative = mean(milit_negative, na.rm = TRUE),
            sd_milit_negative = sd(percent_vote, na.rm = TRUE), 
            median_milit_negatie = median(percent_vote, na.rm = TRUE), 
            iqr_milit_negative = IQR(percent_vote, na.rm = TRUE),
            average_peace = mean(peace, na.rm = TRUE),
            sd_peace = sd(peace, na.rm = TRUE), 
            median_peace = median(peace, na.rm = TRUE), 
            iqr_peace = IQR(peace, na.rm = TRUE))

# glimpse current work
glimpse(summ_df)
  
