module ORM
  class Browsing < ActiveRecord::Base
    set_table_name 'browsing'

    belongs_to :url

    def self.get_sessions
      sessions = Hash.new { |hash, key| hash[key] = [] }

      self.all(:conditions => ["date between ? and ? and operation = 'add'", SDATE, EDATE], :order => 'user_id, id').each do |b|
        session = sessions[b.user_id] 
#        case b.operation
#          when 'add'
#            session << Nav::SessionNode.new(b.url_id, b.date)
#          when 'remove'
#            if !session.empty? and session.last.url_id == b.url_id
#              session.last.till b.date
#            end
#        end
        unless session.last && session.last.url_id == b.url_id
          session << Nav::SessionNode.new(b.url_id, b.date)
        end
      end

      sessions.values
    end
  end
end


