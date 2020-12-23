## Add values to existing database
## -------------------------------
library(DBI)
library(RSQLite)

dbc <- DBI::dbConnect(SQLite(), dbname = "indicator.db")

dbListTables(dbc)
dbGetQuery(dbc, "SELECT  * FROM tbl_source")

df_src <- data.frame(id = 1:2,
                     source = c("NORGESHELSE", "KOMMUNEHELSA"))

dbWriteTable(conn = dbc,
             name = "tbl_source",
             value = df_src,
             overwrite = FALSE,
             append = TRUE)
