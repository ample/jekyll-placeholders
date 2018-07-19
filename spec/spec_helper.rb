require 'rspec'
require 'pry'
require 'bundler/setup'
Bundler.setup
require 'jekyll-placeholders'

Dir['./spec/support/**/*.rb'].each { |f| require f }