class Nav::Spread < Array
  attr_reader :total, :positions

  def initialize
    super
    @total = 0
    @positions = {}
  end

  def add_url url_id
    unless index = positions[url_id]
      positions[url_id] = index = self.size
      push Nav::StatNode.new(url_id)
    end
    self[index].inc
    @total += 1
  end

  def random_url
    guess = Kernel::rand(total) + 1
    running = 0
    self.each do |node|
      running += node.count     
      return node.url_id if running >= guess 
    end
    return empty? ? nil : self[Kernel::rand(self.size)].url_id
  end

  def has? url_id
    positions.has_key? url_id
  end
end