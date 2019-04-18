export default (radius, theta, type, array= false)->
  rad= 2*Math.PI  * theta /360
  d= x: radius*Math.sin(rad), y: radius - radius*Math.cos(rad)
  Identity= (d)-> d
  ReflectX= (d)-> x: d.x, y: -d.y
  ReflectY= (d)-> x: -d.x, y: d.y
  Rotate90= (d)-> x: -d.y, y: d.x
  Transform= switch type
    when 1 then Identity
    when 2 then _.compose Rotate90, ReflectX
    when 3 then Rotate90
    when 4 then ReflectY
    when 5 then _.compose Rotate90, ReflectY, Rotate90, ReflectX
    when 6 then _.compose Rotate90, ReflectY
    when 7 then _.compose ReflectX, Rotate90, ReflectX
    when 8 then ReflectX
  if array? then [Transform(d).x, Transform(d).y] else Transform(d)
