require_relative '../helper'
require_relative '../../lib/geometry/point'

Point = Geometry::Point

class PointTest < Test::Unit::TestCase
    must "create a Point object using list syntax" do
	point = Geometry::Point[2,1]
	assert_equal(2, point.size)
	assert_equal(2, point.x)
	assert_equal(1, point.y)
    end
    must "create a Point object from an array" do
	point = Geometry::Point[[3,4]]
	assert_equal(2, point.size)
	assert_equal(3, point.x)
	assert_equal(4, point.y)
    end
    must "create a Point object from individual parameters" do
	point = Geometry::Point[3,4]
	assert_equal(2, point.size)
	assert_equal(3, point.x)
	assert_equal(4, point.y)
    end
    must "create a Point object from a Vector" do
	point = Geometry::Point[Vector[3,4]]
	assert_equal(2, point.size)
	assert_equal(3, point.x)
	assert_equal(4, point.y)
    end
    must "create a Point object from a Point" do
	point = Geometry::Point[Geometry::Point[3,4]]
	assert_equal(2, point.size)
	assert_equal(3, point.x)
	assert_equal(4, point.y)
    end
    must "create a Point object from a Vector using list syntax" do
	point = Geometry::Point[Vector[3,4]]
	assert_equal(2, point.size)
	assert_equal(3, point.x)
	assert_equal(4, point.y)
    end
    must "create a Point object from a Point using list syntax" do
	point = Geometry::Point[Geometry::Point[13,14]]
	assert_equal(2, point.size)
	assert_equal(13, point.x)
	assert_equal(14, point.y)
    end
    must "allow indexed element access" do
	point = Geometry::Point[5,6]
	assert_equal(2, point.size)
	assert_equal(5, point[0])
	assert_equal(6, point[1])
    end
    must "allow named element access" do
	point = Geometry::Point[5,6,7]
	assert_equal(3, point.size)
	assert_equal(5, point.x)
	assert_equal(6, point.y)
	assert_equal(7, point.z)
    end
    must "compare equal" do
	point1 = Geometry::Point[1,2]
	point2 = Geometry::Point[1,2]
	point3 = Geometry::Point[3,4]
	assert_equal(point1, point2)
	assert_not_equal(point2, point3)
    end

    must "compare equal to an array with equal elements" do
	point1 = Point[1,2]
	assert_equal(point1, [1,2])
    end

    must "not compare equal to an array with unequal elements" do
	point1 = Point[1,2]
	assert_not_equal(point1, [3,2])
    end

    must "implement inspect" do
	point = Geometry::Point[8,9]
	assert_equal('Point[8, 9]', point.inspect)
    end
    must "implement to_s" do
	point = Geometry::Point[10,11]
	assert_equal('Point[10, 11]', point.to_s)
    end
end

class PointArithmeticTest < Test::Unit::TestCase
    def setup
	@left = Point[1,2]
	@right = Point[3,4]
    end

    must "return a Point when adding two Points" do
	assert_kind_of(Point, @left+@right)
    end

    must "return a Point when subtracting two Points" do
	assert_kind_of(Point, @left-@right)
    end
end
