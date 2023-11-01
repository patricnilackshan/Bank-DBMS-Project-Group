## Setting up

In order to connect to the database, we must pass user credentials in `src/mysql-connector.js`. For added security, the password is not hard-coded, instead, it is loaded as an environmenal variable. In development, create a file named .env under `src/` with this content:

```
DATABASE_PASSWORD="<password>"
```
