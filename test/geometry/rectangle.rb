require 'minitest/autorun'
require 'geometry/rectangle'

def Rectangle(*args)
    Geometry::Rectangle.new(*args)
end

Point = Geometry::Point
Size = Geometry::Size

describe Geometry::Rectangle do
    describe "when constructed" do
	it "create a Rectangle object from two Points" do
	    rectangle = Rectangle [1,2], [3,4]
	    assert_kind_of(Geometry::Rectangle, rectangle)
	end

	it "create a Rectangle from a width and height" do
	    rectangle = Rectangle 2, 3
	    assert_kind_of(Geometry::Rectangle, rectangle)
	    assert_equal(2, rectangle.width)
	    assert_equal(3, rectangle.height)
	    assert_equal(Point[0,0], rectangle.center)
	end

	it "create a Rectangle from a Size" do
	    rectangle = Rectangle Size[2, 3]
	    assert_kind_of(Geometry::Rectangle, rectangle)
	    assert_equal(2, rectangle.width)
	    assert_equal(3, rectangle.height)
	    assert_equal(Point[0,0], rectangle.center)
	end

	it "create a Rectangle from an origin Point and Size" do
	    rectangle = Rectangle Point[1,2], Size[2, 3]
	    assert_kind_of(Geometry::Rectangle, rectangle)
	    assert_equal(2, rectangle.width)
	    assert_equal(3, rectangle.height)
	    assert_equal(Point[1,2], rectangle.origin)
	end

	it "create a Rectangle from sides" do
	    rectangle = Rectangle 1,2,3,4
	    assert_kind_of(Geometry::Rectangle, rectangle)
	    assert_equal(2, rectangle.width)
	    assert_equal(2, rectangle.height)
	    assert_equal(Point[1,2], rectangle.origin)
	end
    end

    describe "properties" do
	let(:rectangle) { Rectangle [1,2], [3,4] }

	it "have a center point property" do
	    assert_equal(rectangle.center, [2,3])
	end

	it "have a width property" do
	    assert_equal(2, rectangle.width)
	end

	it "have a height property" do
	    assert_equal(2, rectangle.height)
	end

	it "have an origin property" do
	    assert_equal(Point[1,2], rectangle.origin)
	end

	it "have an edges property that returns 4 edges" do
	    edges = rectangle.edges
	    assert_equal(4, edges.size)
	    edges.each {|edge| assert_kind_of(Geometry::Edge, edge)}
	end

	it "have a points property that returns 4 points" do
	    points = rectangle.points
	    assert_equal(4, points.size)
	    points.each {|point| assert_kind_of(Geometry::Point, point)}
	end
    end
end
