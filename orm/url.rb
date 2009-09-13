class ORM::Url < ActiveRecord::Base
  set_table_name 'url'

  belongs_to :host
end


