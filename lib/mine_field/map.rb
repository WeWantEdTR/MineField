module MineField
  class Map
    attr_reader :size, :points

    def initialize
      print 'Matrix Boyunuz: '

      @size = gets.to_i - 1
      @points = []
      @print_size = @size.to_s.length + 1

      create_points
    end

    def create_points
      mines_points
      other_points
    end

    def draw
      puts `clear`
      header = '| ' + ' ' * (@print_size + 3) + (0..@size).to_a.map {|i| i.to_s.ljust(@print_size)}.join + " |\n"
      seperator = '-' * (header.length - 1) + "\n"

      (0..@size).each do |y|
        if y.zero?
          print seperator
          print header
          print seperator
        end

        print "| #{y.to_s.rjust(@print_size)} | "

        (0..@size).each do |x|
          point = get_point(x, y)

          print "#{point.to_s.ljust(@print_size)}"
          print ' |' if x == @size
        end

        puts ''
      end

      puts seperator
    end

    def get_point(x, y)
      @points.each do |point|
        return point if point.coordinate_x == x && point.coordinate_y == y
      end

      nil
    end

    def visible!
      @points.select {|p| p.opened == false}.each {|p| p.opened = true}
    end

    private

    def mines_points
      mines_count = Math.sqrt(@size + 1).ceil

      loop do
        x = (0..@size).to_a.sample
        y = (0..@size).to_a.sample

        @points.push(Point.new(self, x, y, MINE_CHARACTER)) unless exist_point?(x, y)
        break if @points.size == mines_count
      end
    end

    def other_points
      (0..@size).each do |x|
        (0..@size).each do |y|
          next if exist_point?(x, y)

          @points.push(Point.new(self, x, y, NORMAL_CHARACTER))
        end
      end
    end

    def exist_point?(x, y)
      @points.each do |point|
        return true if point.coordinate_x == x && point.coordinate_y == y
      end

      false
    end
  end
end