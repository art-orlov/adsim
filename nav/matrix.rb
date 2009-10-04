require'set' 

class Nav::Matrix
  attr_reader :spreads, :starts

  def initialize
    @spreads = Hash.new { |hash, key| hash[key] = Nav::Spread.new }
    @starts = Nav::Spread.new
  end

  def add_sessions sessions
    sessions.each do |session|
      next if session.empty?
      #pp session
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

  def iterations_count
    [ spreads.size, starts.total ].max * 10
  end

  def final_var iterations = iterations_count
    Nav::Spread.new.tap do |res|
      (1..iterations).each do
        visited = {}
        url = starts.random_url
        begin
          visited[url] = true
          res.add_url url
          url = spreads[url].try(:random_url)
        end while url && !visited[url]
      end
    end
  end

  def guess_cool_node
    begin
      node = spreads.keys.rand
      l1 = spreads.map do |url, spread|
        spread.has?(node) ? url : nil
      end.compact.to_set
      l2 = spreads.map do |url, spread|
        l1.any? do |l_node|
          spread.has? l_node
        end ? url : nil
      end.compact.to_set
    end while starts.has?(node) or l1.size < 2 or l2.size < 2
    { :node => node, :l1 => l1, :l2 => l2 }
  end
end


