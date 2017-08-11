#\ -s puma
$: << "lib"

require 'rubygems'
require 'rack'
require 'sinatra'
require 'logger'
require 'httparty'
require 'multi_json'
require 'representable'
require 'representable/json'
require 'money'

lib_files = Dir.glob('./lib/**/*.rb').sort
lib_files.each do |requirement|
  require requirement
end

require './home_search'

I18n.enforce_available_locales = false

run HomeSearch
