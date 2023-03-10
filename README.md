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

gem 'arcadedb', git: 'https://github.com/topofocus/arcadedb"
gem 'arcade-time-graph', git: 'https://github.com/topofocus/-arcade-time-graph" 
gem 'bridgetown-arcade-db' , git: 'https://github.com/topofocus/bridgetown-arcade-db"
```
( the gem is not released jet. so, reference to the github-repositories or clone everything an refer to their local location ) 
* activate the plugin in `config/initializers.rb`
``` ruby
init :ssr                         
init :"bridgetown-routes"
init :"bridgetown-arcade-db"
```
or if the DB should only referenced through deployment from static pages
``` ruby
only :static, :console do
 init :bridgetown-arcade-db
end

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
  :host: localhost        # enter ip-address or name of the arcadeDB-Server
  :port: 2480             # 
  :user: root             #  this is used for lowlevel Api-Access
  :pass: ****             #
:autoload: true           #  load model if a link is detected in a record
:logger: stdout           # 'file' or 'stdout'
:namespace: Arcade        #  default namespace
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

1. Fork it (https://github.com/topofocus/bridgetown-arcade-db/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
