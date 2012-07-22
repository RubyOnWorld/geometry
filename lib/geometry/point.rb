require 'matrix'

module Geometry
=begin rdoc
An object repesenting a Point in N-dimensional space

Supports all of the familiar Vector methods and adds convenience
accessors for those variables you learned to hate in your high school
geometry class (x, y, z).

== Usage

=== Constructor
    point = Geometry::Point[x,y]
=end
    class Point < Vector
	attr_reader :x, :y, :z

	# Allow vector-style initialization, but override to support copy-init
	# from Vector or another Point
	#
	# @overload [](x,y,z,...)
	# @overload [](Point)
	# @overload [](Vector)
	def self.[](*array)
	    array = array[0] if array[0].is_a?(Array)
	    array = array[0].to_a if array[0].is_a?(Vector)
	    super *array
	end

	# Allow comparison with an Array, otherwise do the normal thing
	def ==(other)
	    return @elements == other if other.is_a?(Array)
	    super other
	end

	def inspect
	    'Point' + @elements.inspect
	end
	def to_s
	    'Point' + @elements.to_s
	end

	# @param [Integer]  i	Index into the {Point}'s elements
	# @return [Numeric] Element i (starting at 0)
	def [](i)
	    @elements[i]
	end

	# !@attribute [r] x
	# @return [Numeric] X-component
	def x
	    @elements[0]
	end

	# !@attribute [r] y
	# @return [Numeric] Y-component
	def y
	    @elements[1]
	end

	# !@attribute [r] z
	# @return [Numeric] Z-component
	def z
	    @elements[2]
	end

# !@group Arithmetic

	def +(other)
	    raise TypeError, "Integer is not like Vector" if other.is_a?(Integer) and (size != 1)
	    Vector.Raise ErrDimensionMismatch if size != other.size
	    Point[Array.new(size) {|i| @elements[i] + other[i] }]
	end

	def -(other)
	    raise TypeError, "Integer is not like Vector" if other.is_a?(Integer) and (size != 1)
	    Vector.Raise ErrDimensionMismatch if size != other.size
	    Point[Array.new(size) {|i| @elements[i] - other[i] }]
	end

# !@endgroup

    end
end
