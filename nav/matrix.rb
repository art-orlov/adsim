class Nav::Matrix
  attr_reader :spreads, :starts

  def initialize
    @spreads = Hash.new { |hash, key| hash[key] = Nav::Spread.new }
    @starts = Nav::Spread.new
  end

  def add_sessions sessions
    sessions.each do |session|
      starts.add_url session.first.url_id

      session.each_with_index do |node, index|
        next if index == 0

        from, to = session[index - 1].url_id, node.url_id

        if from != to
          spreads[from].add_url to
        end
      end
    end
  end

  def sizes
    Hash.new(0).tap do |sizes|
      spreads.values.each do |s|
        sizes[s.size] += 1
      end
    end
  end

#  def normalize
#    @sources.values.each do |variants|
#      sum = variants.values.inject(0) { |r, v| r + v }
#
#      variants.each { |k, v| variants[k] = 1.0 * v / sum }
#    end
#    @start_points.each do |k, v|
#      @start_points[k] = 1.0 * v / @session_count;
#    end
#  end

  def iterations_count
    [ spreads.count, starts.total ].max * 10
  end

  def final_var iterations = iterations_count
    Spread.new.tap do |res|
      1..iterations.each do
        visited = { (url = starts.random_url) => 1 }
        begin
          url = spreads[url].try(:random_url)
          res.add_url url if url
        end while url && !visited[url]
      end
    end
  end
end


