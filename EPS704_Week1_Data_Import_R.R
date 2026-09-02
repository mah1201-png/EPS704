# =====================================================================
# EPS 704  |  Week 1  |  R  |  Data Import and Entry
# =====================================================================
#
# BEFORE YOU RUN THIS FILE: find the path to your data.
#   1. Put this file and the data file in the SAME folder.
#   2. In RStudio click:  Session > Set Working Directory > To Source File Location.
#      This points R at the folder where this file lives.
#   3. To see the folder R is using right now, run:  getwd()
#   4. If your data sits somewhere else, replace the file name with a full
#      path, for example:  "C:/Users/you/EPS704/enrollment.csv"
# ---------------------------------------------------------------------

library(readr)                          # readr holds read_csv for reading CSV files.
library(readxl)                         # readxl holds read_excel for reading Excel files.

# ---- Read a CSV file -------------------------------------------------
enroll <- read_csv("enrollment.csv")    # read the file and store the table in enroll.
head(enroll)                            # show the first rows to confirm it loaded.
dim(enroll)                             # show the row count and the column count.

# ---- Read one sheet from an Excel workbook ---------------------------
demo <- read_excel("institutional.xlsx", # read the Excel workbook.
                   sheet = "Demographics") # name the sheet so R reads the right tab.
head(demo)                              # show the first rows of the sheet.
dim(demo)                               # show the row count and the column count.
