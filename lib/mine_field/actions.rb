module MineField
  class Actions
    def initialize
      @score = Score.new
      @map = Map.new
    end

    def start
      @map.draw
    end

    def entry
      print "Koordinatlar(x#{PIPE_SYMBOL}y): "
      coordinates = gets.chomp
      x, y = coordinates.split(PIPE_SYMBOL).map(&:to_i)

      if x.nil? || y.nil?
        puts 'Geçersiz bir koordinat girdiniz'
        return
      end

      point = @map.get_point(x, y)

      if point.nil?
        puts 'Geçersiz bir koordinat girdiniz'
        return
      end

      if point.opened
        puts 'Bu koordinat zaten açıldı!'
        return
      end

      point.opened = true

      if point.content == MINE_CHARACTER
        @map.visible!
        @map.draw
        puts 'Mayınlı Bölgeye Bastınız!'
        puts "Puanınız: #{@score.total}"
        exit
      else
        @score.increment
        @map.draw
      end

      # Alanda kalan noktalar sadece mayın mı diye kontrol et
      # Eğer kalanların hepsi mayın ise oyunu başarıyla bitir
      # Değil ise haritayı ekrana çiz
    end

    def finish
      # Ekrana puanı yazdır
      # Restart seçeneği olsun
    end
  end
end