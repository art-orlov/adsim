require 'rubygems'
require 'active_record'

module ORM
  SDATE = Time.utc(2008, 8, 1)
  EDATE = Time.utc(2008, 8, 2)
end

ActiveRecord::Base.establish_connection(
  :adapter => 'mysql' ,
  :host => '127.0.0.1',
  :database => 'browzmi_math',
  :reconnect => true,
  :username => 'root',
  :password => 'root',
  :encoding => 'utf8'
)

require 'orm/host'
require 'orm/url'
require 'orm/browsing'
