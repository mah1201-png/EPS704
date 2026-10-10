# =====================================================================
# EPS 704  |  Week 6  |  R  |  Data Visualization
# =====================================================================
#
# BEFORE YOU RUN THIS FILE: find the path to your data.
#   1. Put this file and the data file in the SAME folder.
#   2. In RStudio click:  Session > Set Working Directory > To Source File Location.
#   3. To see the folder R is using now, run:  getwd()
#   4. If your data sits elsewhere, replace the file name with a full path.
# ---------------------------------------------------------------------

library(readr); library(dplyr); library(ggplot2)
enroll <- read_csv("enrollment.csv")
enroll <- enroll |> mutate(gpa = na_if(gpa, 999))   # 999 is a sentinel for missing gpa.

# ---- Histogram ------------------------------------------------------
ggplot(enroll, aes(x = gpa)) +
  geom_histogram(binwidth = 0.1) +
  labs(title = "Distribution of GPA", x = "GPA", y = "Number of students")

# ---- Scatter with a trend line --------------------------------------
ggplot(enroll, aes(x = credits, y = gpa)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "GPA by credits", x = "Credits", y = "GPA")

# ---- Box plot and bar chart -----------------------------------------
ggplot(enroll, aes(x = degree_level, y = gpa)) + geom_boxplot() +
  labs(title = "GPA by degree level", x = "Degree level", y = "GPA")
ggplot(enroll, aes(x = program)) + geom_bar() +
  labs(title = "Students per program", x = "Program", y = "Number of students") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))   # tilt long labels.

# ---- Colour by group ------------------------------------------------
ggplot(enroll, aes(x = credits, y = gpa, color = degree_level)) +
  geom_point() +
  labs(title = "GPA by credits, colored by degree level",
       x = "Credits", y = "GPA", color = "Degree level")

# ---- Small multiples and save ---------------------------------------
ggplot(enroll, aes(x = credits, y = gpa)) +
  geom_point() +
  facet_wrap(~ program) +                       # one small plot per program.
  labs(title = "GPA by credits, one panel per program", x = "Credits", y = "GPA")
ggsave("gpa_plot.png", width = 9, height = 6)   # save the last plot to a file.

