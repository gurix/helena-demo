# This R-Script is a simple demonstration how to use exported json data from Helena for data analysis

# (Install) and load the rjson package we use to read json files
install.packages("rjson")
library("rjson")

# (Install) and load the plyr package we use to process the json data lists
install.packages("plyr")
library("plyr")

# Read json file from your Helena installation.
# We use here just a stupid simple dump taken localy via http://localhost:3000/helena/admin/surveys/XYZ/sessions.json
# where XYZ is the object id of the seeded survey in the development environment.
json_file <- "example2.json"
json_data <- fromJSON(file=json_file)

# function returning a vecor with code and value for each answer
process_answers <- function(x) {
  v = c(x[['value']])
  names(v) = x[['code']]
  return(v)
}

# function returning session variables and answers as one vector
process_sessions <- function(x) {
  if (is.list(x[['answers']])) {
    c(
      id = x[['_id']][[1]],
      version_id = x[['version_id']][[1]],
      token=x[['token']],
      completed=x[['completed']],
      updated_at=x[['updated_at']],
      view_token=x[['view_token']],
      sapply(x[['answers']],process_answers)
    )
  }
}

# combine session rows to a big dataframe with the drawback that each session must have the same amount of answers
df <- ldply(json_data, "process_sessions")
