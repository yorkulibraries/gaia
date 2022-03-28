# GAIA README

# MUST DO BEFORE RUNNING GAIA

## Database setup
* Create the config/database.yml file if it doesn't exists
* E.g. database.yml
```
  #sqlite example
  development:
    adapter: sqlite3
    database: db/development.sqlite3
    pool: 5
    timeout: 5000

  #mysql example
  production:
      adapter: mysql2
      encoding: utf8
      reconnect: false
      database: <db-name>
      pool: 5
      username: <db-username>
      password: <db-password> or <%= ENV['db-env-password'] %>
      host: mysql.local
      port: 3306

## Setup Mail
* Create file config/gata_settings.yml if doesn't exists

```
  development:
    mail:
      from_name: "DoNoReply"
      from_email: "noreply@domain.com"
      manager_email: "testing@domain.com"

  production:
    mail:
      from_name: "DoNoReply"
      from_email: "noreply@domain.com"
      manager_email: "somemanager@mailinator.com"
