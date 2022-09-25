# load packages
library(tidyverse)
library(kableExtra)

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
ggplot(summ_df3, aes(x=party_fam, y=median_peace)) + geom_point()  + xlab("Party Family") + ylab("Median Peace Mentions")

# plot median mentions of peace by median negative mentions of military
ggplot(summ_df3, aes(x=median_milit_negative, y=median_peace)) + geom_point() + xlab("Median Negative Military Mentions") + ylab("Median Peace Mentions")

# use previous steps create a tighter data frame for table
tight_summ_df <- group_by (df1, party_fam)

tight_summ_df2 <- summarize(tight_summ_df, average_milit_negative = mean(milit_negative, na.rm = TRUE),
                      sd_milit_negative = sd(percent_vote, na.rm = TRUE), 
                      median_milit_negative = median(percent_vote, na.rm = TRUE), 
                      iqr_milit_negative = IQR(percent_vote, na.rm = TRUE),
                      average_peace = mean(peace, na.rm = TRUE),
                      sd_peace = sd(peace, na.rm = TRUE), 
                      median_peace = median(peace, na.rm = TRUE), 
                      iqr_peace = IQR(peace, na.rm = TRUE))

tight_summ_df3 <- tight_summ_df2[-c(1, 3, 4, 5, 8, 10, 12), ]

# wrangle for table
tight_summ_df4 <- pivot_longer(tight_summ_df3, party_fam, values_to = "party_family")
tight_summ_df5 <- subset(tight_summ_df4, select = -c(name) )

# table (pending conversation with carlisle)
table(tight_summ_df5$party_family, tight_summ_df5$average_milit_negative)
