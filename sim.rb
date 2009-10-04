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
    #var1 = matrix.final_var #todo try solving equation to get final var
    #pp var1

    cool_node = matrix.guess_cool_node
    pp cool_node
    #todo modify l2 spreads
  end
end

Sim.new.make