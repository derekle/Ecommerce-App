ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
# Replace the userspace Ruby (OpenSSL) RNG with `/dev/urandom`
require 'sysrandom/securerandom'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite3"
)