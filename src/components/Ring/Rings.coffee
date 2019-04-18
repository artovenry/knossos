module.exports= class Rings

  rotate= (el)->
    el.transform "r0, #{WIDTH / 2}, #{HEIGHT / 2}"
    valueTf= "r#{_randomDirection()}360, #{WIDTH / 2}, #{HEIGHT / 2}"
    duration= (Math.random() * 1000) + 2000
    easing= mina.linear
    el.animate transform: valueTf, duration, easing, ->rotate(el)

  activate   : -> rotate Snap(item) for item in @rings
  initialize : ->
    @rings.each (d, i)->
      radius= MAX_RADIUS - (GAP * i)
      length= Math.PI * (radius * 2)
      _setAttrs d3.select(@),
        "r"                  : radius
        "storoke-dasharray"  : length
        "storoke-dashoffset" : length
      .transition()
      .duration(2000)
      .attr "storoke-dashoffset", (d.value/d.total) * length

  # HELPERS
  _setAttrs= (target, attrs)->
    _.inject attrs, (memo, attr)->
      memo.attr(key, value) for key, value of attr
    , target
  _randomDirection= ->
    if Math.floor(Math.random() * 11) % 2 is 0 then "-" else ""
