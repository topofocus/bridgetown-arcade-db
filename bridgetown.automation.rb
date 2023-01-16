
add_gem "bridgetown-arcade-db"
add_gem "annotate", group: :development

# TODO:  modify  file to enable installation of arcadedb 
#  this is borrowed from bridgetown-activerecord 
#


## do not use ##

create_file "config/arcade.yml" do
  <<~YML
    default: &default
      adapter: #{dbadapter}
      encoding: unicode
      pool: 5

    development:
      <<: *default
      database: #{dbprefix}_development

    test: &test
      <<: *default
      database: #{dbprefix}_test

    production:
      <<: *default
      url: <%= ENV['DATABASE_URL'] %>
      database: #{dbprefix}_production
  YML
end




add_initializer :"bridgetown-arcade-db"

say_status :"arcade-db", "The plugin has been configured. For usage help visit:"
say_status :"arcade-db", "https://github.com/topofocus/arcade-db/blob/main/README.md"

