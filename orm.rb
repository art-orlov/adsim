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

#url
#SELECT * FROM url JOIN HOST ON url.host_id = host.id WHERE url.id = ?

#session
#SELECT b.date, b.operation, b.window_id, CONCAT(h.full_name, u.file) FROM browsing b
#LEFT JOIN url u ON b.url_id = u.id
#LEFT JOIN HOST h ON u.host_id = h.id
#WHERE b.user_id = ?
#ORDER BY b.id
