class Nav::Matrix
  attr_reader :sources

  def initialize
    @sources = Hash.new { |hash, key| hash[key] = Hash.new(0) }
  end

  def add_sessions sessions
    sessions.each do |session|
      session.each_with_index do |node, index|
        next if index == 0

        from, to = session[index - 1].url_id, node.url_id

        if from != to
          @sources[from][to] += 1
        end
      end
    end
  end

  def sizes
    Hash.new(0).tap do |sizes|
      @sources.values.each do |s|
        sizes[s.keys.size] += 1
      end
    end
  end

  def normalize
    @sources.values.each do |variants|
      sum = variants.values.inject(0) { |r, v| r + v }

      variants.each { |k, v| variants[k] = 1.0 * v / sum }
    end
  end
end


