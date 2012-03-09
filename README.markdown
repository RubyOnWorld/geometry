Geometry for Ruby
=================

Classes and methods for the handling of all of the basic geometry that you 
learned in high school (and then forgot).

The classes in this libary are based on the Vector class provided by the Ruby 
standard library. Geometric primitives are generally assumed to lie in 2D space,
but aren't necessarily restricted to it. Please let me know if you find cases 
that don't work in higher dimensions and I'll do my best to fix them.

License
-------

Copyright 2012 Brandon Fosdick <bfoz@bfoz.net> and released under the BSD 
license.

Primitives
----------

- Point
- Line

Examples
--------

### Point
```ruby
    point = Geometry::Point[3,4]    # 2D Point at coordinate 3, 4
    point = Geometry.Point(1,2)	    # Functional constructor

    # Copy constructors
    point2 = Geometry::Point[point]
    point2 = Geometry::Point[Vector[5,6]]

    # Accessors
    point.x
    point.y
    point[2]	# Same as point.z
```

### Line
```ruby
    # Two-point constructors
    line = Geometry::Line[[0,0], [10,10]]
    line = Geometry::Line[Geometry::Point[0,0], Geometry::Point[10,10]]
    line = Geometry::Line[Vector[0,0], Vector[10,10]]

    # Slope-intercept constructors
    Geometry::Line[Rational(3,4), 5]	# Slope = 3/4, Intercept = 5
    Geometry::Line[0.75, 5]

    # Point-slope constructors
    Geometry::Line(Geometry::Point[0,0], 0.75)
    Geometry::Line(Vector[0,0], Rational(3,4))

    # Special constructors (2D only)
    Geometry::Line.horizontal(y=0)
    Geometry::Line.vertical(x=0)
```