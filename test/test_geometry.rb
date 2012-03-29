require_relative 'helper'
require_relative '../lib/geometry'

class GeometryTest < Test::Unit::TestCase
    must "create a Point object" do
	point = Geometry.point(2,1)
	assert_kind_of(Geometry::Point, point)
    end
    must "create a Line object" do
	line = Geometry.line([0,0], [10,10])
	assert_kind_of(Geometry::Line, line)
	assert_kind_of(Geometry::TwoPointLine, line)
    end
end
