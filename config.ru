#\ -s puma
$: << "lib"
$: << "models"

require 'rubygems'
require 'rack'
require 'sinatra'
require 'logger'
require 'httparty'
require 'multi_json'
require 'representable'
require 'representable/json'

lib_files = Dir.glob('./lib/**/*.rb').sort
lib_files.each do |requirement|
  require requirement
end

require './home_search'

run HomeSearch
