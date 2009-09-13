require 'nav'
require 'orm'
require 'pp'

module ImportMatrix
  def self.do_import
    Nav::Matrix.new.tap do |m|
      m.add_sessions ORM::Browsing.get_sessions

      m.normalize

      pp m.sizes
    end
  end
end
