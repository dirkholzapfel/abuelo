$: << File.join(File.dirname(__FILE__), '/../lib')
require "#{File.dirname(__FILE__)}/../lib/abuelo"
require 'pry'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end