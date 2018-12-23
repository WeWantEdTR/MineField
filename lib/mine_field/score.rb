module MineField
  class Score
    attr_reader :total

    def initialize
      @total = 0
    end

    def increment(score = 1)
      @total += score
    end
  end
end
