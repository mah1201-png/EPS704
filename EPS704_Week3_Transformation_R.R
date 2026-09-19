# =====================================================================
# EPS 704  |  Week 3  |  R  |  Data Transformation and Aggregation
# =====================================================================
#
# BEFORE YOU RUN THIS FILE: find the path to your data.
#   1. Put this file and the data file in the SAME folder.
#   2. In RStudio click:  Session > Set Working Directory > To Source File Location.
#   3. To see the folder R is using now, run:  getwd()
#   4. If your data sits elsewhere, replace the file name with a full path.
# ---------------------------------------------------------------------

library(readr); library(dplyr); library(tidyr)   # load the toolboxes.

enroll   <- read_csv("enrollment.csv")  # main table.
advisors <- read_csv("advisors.csv")    # advisor details to join later.
scores   <- read_csv("scores_wide.csv") # wide scores to reshape.

# ---- Create a new variable ------------------------------------------
enroll <- enroll |>
  mutate(gpa = na_if(gpa, 999)) |>                     # mark the 999 code as missing.
  mutate(gpa_group = case_when(                        # build a label from gpa.
    is.na(gpa) ~ NA_character_,                        # missing gpa stays missing.
    gpa >= 3.5 ~ "High",
    gpa >= 3.0 ~ "Middle",
    TRUE ~ "Low"))


# ---- Summarise by group ---------------------------------------------
enroll |>
  group_by(program) |>                   # one group per program.
  summarise(mean_gpa = mean(gpa, na.rm = TRUE),   # average gpa per group.
            students = n())              # count per group.

# ---- Reshape wide to long, and back ---------------------------------
long <- scores |>
  pivot_longer(cols = c(midterm, final, project), # stack three columns.
               names_to = "score_type",           # old names go here.
               values_to = "score")               # numbers go here.
wide <- long |>
  pivot_wider(names_from = score_type,            # spread the label back out.
              values_from = score)                # fill with the numbers.

# ---- Summarise several columns at once ------------------------------
enroll |>
  group_by(program) |>
  summarise(across(c(gpa, credits), mean, na.rm = TRUE))  # average both columns.

# ---- Join two tables ------------------------------------------------
joined <- enroll |>
  left_join(advisors, by = "advisor_id") # add advisor details, matched on advisor_id.
head(joined)
