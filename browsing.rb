require 'active_record'

class Browsing < ActiveRecord::Base
  def self.get_users
    all :select => 'distinct user_id'
  end

  def self.get_user_sessions user_id
    all :conditions => { :user_id => user_id }, :order => 'date'
  end
end