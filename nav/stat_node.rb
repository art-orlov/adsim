class Nav::StatNode
  attr_reader :url_id, :count

  def initialize url_id
    @url_id = url_id
    @count = 0
  end

  def inc
    @count += 1
  end
end
