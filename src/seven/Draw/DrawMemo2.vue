  class Draw
    constructor: (@c, @absolute)->
      @words= _.compact(@c.split " ")
    origin: -> if @absolute then x: @cmd.x, y: @cmd.y else x: 0, y: 0
  class DrawLine extends Draw
    cmd: ->
      _.object ["x", "y", "dx", "dy"] , do =>
        if @absolute
          [+words[0], +words[1], +words[3], +words[4]]
        else
          [0 ,0 ,+words[1], +words[2]]
    d: ->"m #{@origin.x} #{@origin.y} l #{@cmd.dx} #{@cmd.dy}"
    delta: -> x: @cmd.dx, y: @cmd.dy
    length: ->Math.sqrt(Math.pow(@cmd.dx, 2)+Math.pow(@cmd.dy,2))
  class DrawCurve extends Draw
    cmd: ->
      [r, cType, theta]= words[(if @absolute then 3 else 1)..]
      x: if @absolute then +words[0] else 0
      y: if @absolute then +words[1] else 0
      r: +r, cType: +cType, theta: +theta
    d: ->
      path= do =>
        longArc= if @cmd.theta <=180 then 0 else 1
        rotation= if @cmd.cType % 2 is 0 then 0 else 1
        "a #{@cmd.r} #{@cmd.r} 0 #{longArc} #{rotation} #{@delta.x} #{@delta.y}"
      "m #{@origin.x} #{@origin.y} #{path}"
    delta: ->
      rad= 2*Math.PI  * @cmd.theta /360
      longArc= if @cmd.theta <=180 then 0 else 1
      rotation= if @cmd.cType % 2 is 0 then 0 else 1
      d= x: @cmd.r*Math.sin(rad), y: @cmd.r - @cmd.r*Math.cos(rad)
      Identity= (d)-> d
      ReflectX= (d)-> x: d.x, y: -d.y
      ReflectY= (d)-> x: -d.x, y: d.y
      Rotate90= (d)-> x: -d.y, y: d.x
      Transform= switch @cmd.cType
        when 1 then Identity
        when 2 then _.compose Rotate90, ReflectX
        when 3 then Rotate90
        when 4 then ReflectY
        when 5 then _.compose Rotate90, ReflectY, Rotate90, ReflectX
        when 6 then _.compose Rotate90, ReflectY
        when 7 then _.compose ReflectX, Rotate90, ReflectX
        when 8 then ReflectX
      return  x: Transform(d).x,  y:Transform(d).y
    length: ->2*@cmd.r*Math.PI  * @cmd.theta / 360
