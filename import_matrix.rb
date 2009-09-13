require 'active_support'
require 'browsing'

module ImportMatrix
  def self.do_import
    Matrix.new.tap do |matrix|
      Browsing.get_users.each do |user_id|
        sessions = Browsing.get_user_sessions user_id
        
      end
    end
  end
end