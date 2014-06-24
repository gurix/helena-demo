# This R-Script is a simple demonstration how to use exported csv data from Helena for data analysis

# Read csv file from your Helena installation.
# We use here just a stupid simple dump taken localy via http://localhost:3000/helena/admin/surveys/XYZ/sessions.csv
# where XYZ is the object id of the seeded survey in the development environment.

df <- read.csv('example1.csv')

# That's all, really :-)
