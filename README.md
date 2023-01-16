# Bridgetown ArcadeDB plugin

This plugin grants Bridgetown sites (v1.2 or higher) to ArcadeDB-Databases. You can pull data from a database during a static build or during server requests (or both!). [ArcadeDB](https://arcadedb.com/) is a multi-model NOSQL-Database supporting Document-, KeyStore- 
and  Graph-Databases including standard-protocols (SQL, Redis, MongoDB, Gremlin, GraphQL). Most important: ArcadeDB supports inheritance,
ArcadDB is a native object-orientated database. This fits nicely to ruby. 

## Installation

An automation script is planned

```shell
$ bin/bridgetown apply https://github.com/bridgetownrb/bridgetown-arcade-db   (future use)
```

Manual setup:

* Add the following to `Gemfile` 
```
gem 'bridgetown-arcade-db'
gem 'arcadedb'
gem 'arcade-time-graph'
```
( the gem is not released jet. so, reference to the github-repositories or clone everything an refer to their local location ) 
* activate the plugin in `config/initializers.rb`
```
init :ssr
init :"bridgetown-routes"
init :"bridgetown-arcade-db"
```

* add `arcade.yml` to the `config`-dir
```
--- #/config/arcade.yml
:environment:
:test:
dbname: test
user:  root
pass: ****
:development:
dbname: playground
user: root
pass: ****      
:production:
dbname: bridgetown
user: root
pass: ****      
:admin:
:host: localhost
:port: 2480
:user: root
:pass: ****
:modeldir: model
:logger: stdout           # 'file' or 'stdout'
:namespace: Arcade
```

* create a `model`-directory, and there an `arcade`-Namespace-Directory.
* for testing: create a file `model/arcade/person.rb`
```
module Arcade
class Person
attribute :name,        Types::Nominal::String
attribute :surname,     Types::Nominal::String.default( "".freeze   )
attribute :email?,      Types::Email
attribute :age?,        Types::Nominal::Integer
attribute :active,      Types::Nominal::Bool.default( true   )
attribute :conterfeil?, Types::Nominal::Any

def self.db_init
File.read(__FILE__).gsub(/.*__END__/m, '')
end
end
end
## The code below is executed on the database after the database-type is created
## Use the output of `ModelClass.database_name` as DB type  name
##
__END__
CREATE PROPERTY user.name STRING
CREATE PROPERTY user.surname STRING
CREATE PROPERTY user.email STRING
CREATE INDEX  ON user ( name   ) NOTUNIQUE
CREATE INDEX  ON user ( name, surname, email   ) UNIQUE
```

* Assuming you got a running database-instance, you are ready to go.

## First steps

* Create the database 
  * Open the Bridgetown-Console (bin/bt c)
  * execute `Api.create_database {name of the database in arcade.yml}`
* create the  Person type: `Arcade::Person.create_type`
* add a person: `Arcade::Person.create name: "Hogo"`
* query the database: `Arcade::Person.where name: 'Hugo'`

The records are available in Frontmatter, components and in Bridgetown-Documents. 


## Contributing

1. Fork it (https://github.com/bridgetownrb/bridgetown-activerecord/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
