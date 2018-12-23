module MineField
  class Point
    attr_reader :coordinate_x, :coordinate_y, :content
    attr_accessor :opened

    def initialize(map, x, y, content)
      @coordinate_x = x
      @coordinate_y = y
      @content = content
      @opened = false
      @map = map
    end

    def neighbors
      items = []

      ((@coordinate_x - 1)..(@coordinate_x + 1)).each do |x|
        ((@coordinate_y - 1)..(@coordinate_y + 1)).each do |y|
          point = @map.get_point(x, y)
          items.push(point) unless point.nil?
        end
      end

      items
    end

    def to_s
      if @opened
        if @content == MINE_CHARACTER
          MINE_CHARACTER
        else
          neighbors.select {|p| p.content == MINE_CHARACTER}.count.to_s
        end
      else
        NOT_OPENED_CHARACTER
      end
    end
  end
end