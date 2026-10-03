# =====================================================================
# EPS 704  |  Week 5  |  R  |  Exploratory Analysis and Statistics
# =====================================================================
#
# BEFORE YOU RUN THIS FILE: find the path to your data.
#   1. Put this file and the data file in the SAME folder.
#   2. In RStudio click:  Session > Set Working Directory > To Source File Location.
#   3. To see the folder R is using now, run:  getwd()
#   4. If your data sits elsewhere, replace the file name with a full path.
# ---------------------------------------------------------------------

library(readr)
enroll <- read_csv("enrollment.csv")
library(dplyr)
enroll <- enroll |> mutate(gpa = na_if(gpa, 999))   # 999 is a sentinel for missing gpa.
# ---- Correlation ----------------------------------------------------
cor(enroll$gpa, enroll$credits, use = "complete.obs")   # link between two numbers.
cor.test(enroll$gpa, enroll$credits)                    # link plus a p value.

# ---- t test (two groups) and ANOVA (three or more) ------------------
t.test(gpa ~ graduated, data = enroll)                  # compare two groups.
summary(aov(gpa ~ program, data = enroll))              # compare many groups.
enroll |> group_by(graduated) |> summarise(mean_gpa = mean(gpa, na.rm = TRUE))
# ---- Chi square (two categories) ------------------------------------
tab <- table(enroll$degree_level, enroll$graduated)     # two way table.
chisq.test(tab)                                         # are the categories linked?

# ---- Simple regression (predict a number) ---------------------------
model <- lm(gpa ~ credits, data = enroll)               # fit a straight line.
summary(model)                                         # slope and its p value.

# ---- Paired t test (same students, before and after) ----------------
pp <- read_csv("pre_post_scores.csv")                   # pre and post for each student.
t.test(pp$post, pp$pre, paired = TRUE)                  # did scores change?
