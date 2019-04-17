require "design/Design3/underscoreExtension"
import orquestra from "design/Design3/orquestra"
DISTRIBUTE_OPTIONS=
  axis:x:800,y:550
  pr:[30, 30, 30,30,30,30,30]
  dy:[0, 0, 0,0,0,0,0, 0]
  scales:[1,1,1,1,1,1,1,1]

###
SCHEMA: [{d:***, transform: ***}, {d:***, transform: ***}, ...]
###

data= _.map orquestra, (item)->
  squeezeArray= (ary)->_.inject ary, ((m, i)->"#{m} #{i.join(" ")}"), ""
  d: [squeezeArray Snap.path.toRelative(item.d)]
  width: item.width, height: item.height

iterat= (item, index)->item + (DISTRIBUTE_OPTIONS.pr[index] ? 0)

[widths,heights] = [_.pluck(data, "width"), _.pluck(data, "height")]
[yokohaba, tatehaba]= [_.sum(widths, iterat), _.max(heights)]

[x, y]= [DISTRIBUTE_OPTIONS.axis.x - yokohaba / 2, DISTRIBUTE_OPTIONS.axis.y]

translateForDistribution= (item, key, list)->
  index= _.indexOf _.values(list), item
  dx= if index is 0 then 0 else _.sum widths, iterat, 0, (index - 1)
  dy= (-1) * item.height / 2  + DISTRIBUTE_OPTIONS.dy[index]
  "translate(#{x + dx} #{y + dy})"

export default _.map data, (item, key, list)->
  d: item.d
  transform: translateForDistribution(item, key, list)
