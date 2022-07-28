## Solution

Implemented a simple schema (close to the CSV data format) including a foreign key constraint on the place. This is to help with faster querying, however one drawback is the longer import time.

Regarding the query output, pure SQL is used for the query and a json file is produced as requested.

Follow the instructions as given in the code test:

### Build the docker images

```
docker compose build
```

### Start the MySQL database

```
docker compose up database
```

Make sure the MySQL database is running, and then load the example schema with:

```
docker compose run --no-TTY database mysql --host=database --user=codetest --password=swordfish codetest <schema.sql
```

### Run the import and output ruby scripts

```
docker compose run import
docker compose run output
```

`data\summary_output.json` holds the result of the query
