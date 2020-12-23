## Create tables in SQLite
## ------------------------
library(DBI)
library(RSQLite)

dbc <- DBI::dbConnect(SQLite(), dbname = "indicator.db")


sq_title <-  '
CREATE TABLE "tbl_title" (
	"id"	         INTEGER NOT NULL UNIQUE,
	"rap"	         INTEGER,
	"title"	         TEXT NOT NULL,
	"intro"	         TEXT,
	"def"	         TEXT,
	"dim_kh"	 TEXT,
	"dim_nh"	 TEXT,
	"file_kh"	 TEXT,
	"file_nh"	 TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
'

DBI::dbSendQuery(
  conn = dbc,
  statement = sq_title)


sq_section <- '
CREATE TABLE "tbl_section" (
       "id"     INTEGER,
       "title"  TEXT,
       "sect"   TEXT,
       FOREIGN KEY(id) REFERENCES tbl_title(id)
);
'

RSQLite::dbSendQuery(
  conn = dbc,
  statement = sq_section)



RSQLite::dbSendQuery(
  conn = dbc,
  "CREATE TABLE tbl_title(
   id INTEGER,
   tkort TEXT,
   title TEXT,
   PRIMARY KEY (id))",
  overwrite = TRUE)







## Create tables R ways with data.frame
## ------------------------------------
## But can't specify PRIMARY or FOREIGN KEY
## Can be used to add data to database
library(RSQLite)
dbc2 <- RSQLite::dbConnect(SQLite(), dbname = "indicator2.db")

df_title <- data.frame(id = integer(),
                       rap = integer(),
                       title = character(),
                       intro = character(),
                       stringsAsFactors = FALSE
                       )

DBI::dbWriteTable(conn = dbc2,
                  name = "tbl_title",
                  value = df_title,
                  overwrite = FALSE,
                  append = TRUE)
