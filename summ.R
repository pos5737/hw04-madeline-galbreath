# integrate the tidyverse
library(tidyverse)

# read in the tidy dataset
df1 <- read_rds("data/manifesto_tidy.rds")

# group by party family and vote percentage
summ_df <- group_by (df1, party_fam, party)

# compute measures of location and scale
summ_df2 <- summarize(summ_df, average_milit_negative = mean(milit_negative, na.rm = TRUE),
            sd_milit_negative = sd(percent_vote, na.rm = TRUE), 
            median_milit_negative = median(percent_vote, na.rm = TRUE), 
            iqr_milit_negative = IQR(percent_vote, na.rm = TRUE),
            average_peace = mean(peace, na.rm = TRUE),
            sd_peace = sd(peace, na.rm = TRUE), 
            median_peace = median(peace, na.rm = TRUE), 
            iqr_peace = IQR(peace, na.rm = TRUE))

# glimpse current work
glimpse(summ_df2)

# focus on more common party types
summ_df3 <- summ_df2[-c(1:38, 200:383, 743:746, 859:949, 1141:1201), ]

# plot median mentions of peace by party, stratified by party family
ggplot(summ_df3, aes(x=party_fam, y=median_peace)) + geom_point()

# plot median mentions of peace by median negative mentions of military
ggplot(summ_df3, aes(x=median_peace, y=median_milit_negative)) + geom_point()
