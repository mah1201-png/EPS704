# =====================================================================
# EPS 704  |  Week 4  |  R  |  Descriptive Statistics
# =====================================================================
#
# BEFORE YOU RUN THIS FILE: find the path to your data.
#   1. Put this file and the data file in the SAME folder.
#   2. In RStudio click:  Session > Set Working Directory > To Source File Location.
#   3. To see the folder R is using now, run:  getwd()
#   4. If your data sits elsewhere, replace the file name with a full path.
# ---------------------------------------------------------------------

library(readr); library(dplyr)
enroll <- enroll |> mutate(gpa = na_if(gpa, 999))   # 999 is a sentinel for missing gpa.

# ---- One-number summaries -------------------------------------------
mean(enroll$gpa, na.rm = TRUE)          # average gpa.
sd(enroll$gpa, na.rm = TRUE)            # spread of gpa.
summary(enroll$gpa)                     # five number summary.

# ---- Counts and group summaries -------------------------------------
table(enroll$program)                   # students per program.
enroll |> group_by(program) |>
  summarise(mean_gpa = mean(gpa, na.rm = TRUE), students = n())

# ---- Two way table (cross tab) --------------------------------------
table(enroll$program, enroll$degree_level)   # programs down, degree levels across.

# ---- Correlation matrix ---------------------------------------------
cor(enroll[c("gpa", "credits", "gre_q", "gre_v")],   # several numbers at once.
    use = "complete.obs")               # use rows with all values present.
