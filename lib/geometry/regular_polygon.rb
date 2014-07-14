require_relative 'cluster_factory'
require_relative 'polygon'

module Geometry
=begin rdoc
A {RegularPolygon} is a lot like a {Polygon}, but more regular.

{http://en.wikipedia.org/wiki/Regular_polygon}

== Usage
    polygon = Geometry::RegularPolygon.new sides:4, center:[1,2], radius:3
    polygon = Geometry::RegularPolygon.new sides:6, center:[1,2], diameter:6
=end

    class RegularPolygon < Polygon
	include ClusterFactory

	# @return [Point]   The {RegularPolygon}'s center point
	attr_reader :center

	# @return [Number]  The {RegularPolygon}'s number of sides
	attr_reader :edge_count

	# @return [Number]  The {RegularPolygon}'s radius
	attr_reader :radius
	alias :circumradius :radius

	# @overload new(sides, center, radius)
	#   Construct a {RegularPolygon} using a center point and radius
	#   @option options [Number]	:sides	The number of edges
	#   @option options [Point]	:center	(PointZero) The center point of the {RegularPolygon}
	#   @option options [Number]	:radius The circumradius of the {RegularPolygon}
	# @overload new(sides, center, inradius)
	#   Construct a {RegularPolygon} using a center point and radius
	#   @option options [Number]	:sides	The number of edges
	#   @option options [Point]	:center	(PointZero) The center point of the {RegularPolygon}
	#   @option options [Number]	:inradius   The inradius of the {RegularPolygon}
	# @overload new(sides, center, diameter)
	#   Construct a {RegularPolygon} using a center point and diameter
	#   @option options [Number]	:sides  The number of edges
	#   @option options [Point]	:center	(PointZero) The center point of the {RegularPolygon}
	#   @option options [Number]	:diameter   The circumdiameter of the {RegularPolygon}
	# @overload new(sides, center, indiameter)
	#   Construct a {RegularPolygon} using a center point and diameter
	#   @option options [Number]	:sides  The number of edges
	#   @option options [Point]	:center	(PointZero) The center point of the {RegularPolygon}
	#   @option options [Number]	:indiameter   The circumdiameter of the {RegularPolygon}
	def self.new(options={}, &block)
	    raise ArgumentError, "RegularPolygon requires an edge count" unless options[:sides]

	    center = options[:center]
	    center = center ? Point[center] : Point.zero

	    if options.has_key?(:radius)
		self.allocate.tap {|polygon| polygon.send :initialize, options[:sides], center, options[:radius], &block }
	    elsif options.has_key?(:inradius)
		InradiusRegularPolygon.new options[:sides], center, options[:inradius], &block
	    elsif options.has_key?(:indiameter)
		IndiameterRegularPolygon.new options[:sides], center, options[:indiameter], &block
	    elsif options.has_key?(:diameter)
		DiameterRegularPolygon.new options[:sides], center, options[:diameter], &block
	    else
		raise ArgumentError, "RegularPolygon.new requires a radius or a diameter"
	    end
	end

	# Construct a new {RegularPolygon} from a centerpoint and radius
	# @param    [Number]	edge_count  The number of edges
	# @param    [Point]	center  The center point of the {Circle}
	# @param    [Number]	radius  The circumradius of the {RegularPolygon}
	# @return   [RegularPolygon]	A new {RegularPolygon} object
	def initialize(edge_count, center, radius)
	    @center = Point[center]
	    @edge_count = edge_count
	    @radius = radius
	end

	def eql?(other)
	    (self.center == other.center) && (self.edge_count == other.edge_count) && (self.radius == other.radius)
	end
	alias :== :eql?

	# Check to see if the {Polygon} is closed (always true)
	# @return [True] Always true because a {Polygon} is always closed
	def closed?
	    true
	end

# @!group Accessors
	# @return [Rectangle]	The smallest axis-aligned {Rectangle} that bounds the receiver
	def bounds
	    return Rectangle.new(self.min, self.max)
	end

	# @!attribute [r] diameter
	#   @return [Numeric] The diameter of the {RegularPolygon}
	def diameter
	    @radius*2
	end

	# !@attribute [r] edges
	def edges
	    points = self.vertices
	    points.each_cons(2).map {|p1,p2| Edge.new(p1,p2) } + [Edge.new(points.last, points.first)]
	end

	# !@attribute [r] vertices
	#   @return [Array]
	def vertices
	    (0...2*Math::PI).step(2*Math::PI/edge_count).map {|angle| center + Point[Math::cos(angle), Math::sin(angle)]*radius }
	end
	alias :points :vertices

	# @return [Point]   The upper right corner of the bounding {Rectangle}
	def max
	    @center+Point[radius, radius]
	end

	# @return [Point]   The lower left corner of the bounding {Rectangle}
	def min
	    @center-Point[radius, radius]
	end

	# @return [Array<Point>]    The lower left and upper right corners of the bounding {Rectangle}
	def minmax
	    [self.min, self.max]
	end

	# @!attribute indiameter
	#   @return [Number]  the indiameter
	def indiameter
	    2*inradius
	end

	# @!attribute inradius
	#   @return [Number]  The inradius
	def inradius
	    circumradius * Math.cos(Math::PI/edge_count)
	end

	# @!attribute [r] side_length
	#   @return [Number]  The length of each side
	def side_length
	    2 * circumradius * Math.sin(Math::PI/edge_count)
	end

# @!endgroup
    end

    class InradiusRegularPolygon < RegularPolygon
	# @!attribute inradius
	#   @return [Number]  the inradius
	attr_reader :inradius

	# Construct a new {RegularPolygon} from a centerpoint and a diameter
	# @param    [Number]	edge_count  The number of edges
	# @param    [Point]	center  The center point of the {RegularPolygon}
	# @param    [Number]	diameter  The radius of the {RegularPolygon}
	# @return   [InradiusRegularPolygon]	A new {RegularPolygon} object
	def initialize(edge_count, center, inradius)
	    @center = center ? Point[center] : nil
	    @edge_count = edge_count
	    @inradius = inradius
	end

	# @!attribute circumradius
	#   @return [Number]  the circumradius (calculated from inradius)
	def circumradius
	    inradius / Math.cos(Math::PI/edge_count)
	end
	alias :radius :circumradius
    end

    class IndiameterRegularPolygon < RegularPolygon
	# @!attribute inradius
	#   @return [Number]  the inradius
	attr_reader :indiameter

	# Construct a new {RegularPolygon} from a centerpoint and a diameter
	# @param    [Number]	edge_count  The number of edges
	# @param    [Point]	center  The center point of the {RegularPolygon}
	# @param    [Number]	diameter  The radius of the {RegularPolygon}
	# @return   [InradiusRegularPolygon]	A new {RegularPolygon} object
	def initialize(edge_count, center, indiameter)
	    @center = center ? Point[center] : nil
	    @edge_count = edge_count
	    @indiameter = indiameter
	end

	# @!attribute circumdiameter
	#   @return [Number]  the circumdiameter (calculated from indiameter
	def circumdiameter
	    indiameter/Math.cos(Math::PI/edge_count)
	end
	alias :diameter :circumdiameter

	# @!attribute circumradius
	#   @return [Number]  the circumradius (calculated from indiameter)
	def circumradius
	    circumdiameter/2
	end
	alias :radius :circumradius

	# @!attribute inradius
	#   @return [Number]  the inradius (calculated from indiameter)
	def inradius
	    indiameter/2
	end
    end

    class DiameterRegularPolygon < RegularPolygon
	# @return [Number]  The {RegularPolygon}'s diameter
	attr_reader :diameter

	# Construct a new {RegularPolygon} from a centerpoint and a diameter
	# @param    [Number]	edge_count  The number of edges
	# @param    [Point]	center  The center point of the {RegularPolygon}
	# @param    [Number]	diameter  The radius of the {RegularPolygon}
	# @return   [RegularPolygon]	A new {RegularPolygon} object
	def initialize(edge_count, center, diameter)
	    @center = center ? Point[center] : nil
	    @edge_count = edge_count
	    @diameter = diameter
	end

	def eql?(other)
	    (self.center == other.center) && (self.edge_count == other.edge_count) && (self.diameter == other.diameter)
	end
	alias :== :eql?

# @!group Accessors
	# @return [Number] The {RegularPolygon}'s radius
	def radius
	    @diameter/2
	end
# @!endgroup
    end
end
