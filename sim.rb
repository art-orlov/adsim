require 'all'

class Sim
  def import_matrix
    Nav::Matrix.new.tap do |m|
      m.add_sessions ORM::Browsing.get_sessions

      #pp m.sizes
    end
  end

  def make
    matrix = import_matrix
    #solve equation to get final var
    var1 = matrix.final_var
    pp var1
  end
end

Sim.new.make