begin
  require "bundler/inline"
rescue LoadError => e
  $stderr.puts "Bundler version 1.10 or later is required. Please update your Bundler"
  raise e
end

require "active_record"
require "logger"
require "mysql2"
require "yaml"
require "digest/md5"

db_development_settings = YAML.load_file("database_development.yml")
db_production_settings = YAML.load_file("database_production.yml")

db_config_development_admin = {
  adapter: db_development_settings["adapter"],
  username: db_development_settings["username"],
  password: db_development_settings["password"],
  host: db_development_settings["host"] || "localhost",
}
db_config_production_admin = {
  adapter: db_production_settings["adapter"],
  username: db_production_settings["username"],
  password: db_production_settings["password"],
  host: db_production_settings["host"] || "localhost",
}
db_config_development = db_config_development_admin.merge(database: db_development_settings["database"])
db_config_production = db_config_production_admin.merge(database: db_production_settings["database"])

ActiveRecord::Base.establish_connection db_config_development_admin
ActiveRecord::Base.connection.drop_database db_config_development[:database] rescue nil
ActiveRecord::Base.connection.create_database db_config_development[:database] rescue nil
ActiveRecord::Base.connection.close
ActiveRecord::Base.establish_connection db_config_development
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :email
    t.string :encrypted_password
    t.datetime :created_at
    t.datetime :updated_at
  end

  create_table :products do |t|
    t.string  :name
    t.integer :status_id, default: 0
    t.string  :image_path, limit: 512
    t.datetime :created_at
    t.datetime :updated_at
  end
end

ActiveRecord::Base.connection.close
ActiveRecord::Base.establish_connection db_config_production_admin
ActiveRecord::Base.connection.drop_database db_config_production[:database] rescue nil
ActiveRecord::Base.connection.create_database db_config_production[:database] rescue nil
ActiveRecord::Base.establish_connection db_config_production
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :email
    t.string :encrypted_password
    t.datetime :created_at
    t.datetime :updated_at
  end

  create_table :products do |t|
    t.string  :name
    t.string  :image_path, limit: 512
    t.datetime :created_at
    t.datetime :updated_at
  end
end

class User < ActiveRecord::Base
end

class Product < ActiveRecord::Base
end

2000.times.each do |i|
  User.create(
    email: "test_email_#{i}@example.com",
    encrypted_password: Digest::MD5.hexdigest(i.to_s),
  )
end

10000.times.each do |i|
  Product.create(
    name: "production_product_#{i}",
    image_path: "/test/image/#{i}.png"
  )
end
