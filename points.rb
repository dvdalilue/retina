class Point
    attr_accessor :x, :y

    def initialize x, y
        @x = x.to_f
        @y = y.to_f
    end

    def self.gradient p1, p2
        (p2.y - p1.y) / (p2.x - p1.x)
    end

    def to_s
        "(#{@x.to_i},#{@y.to_i})"
    end
end

def discretePoints p1, p2, m
    (p1.x.to_i..p2.x.to_i).map { |x| Point.new(x, (m * (x.to_f - p2.x) + p2.y).round) }
end

point_1 = Point.new(15,3)
point_2 = Point.new(60,20)
gradient = Point.gradient point_1, point_2

puts discretePoints point_1, point_2, gradient