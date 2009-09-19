class Nav::SessionNode
  attr_reader :url_id, :date, :interval

  def initialize url_id, date
    @url_id = url_id
    @date = date
  end

  def till date
    @interval = date - @date
  end
end
