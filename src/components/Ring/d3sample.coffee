# https://codepen.io/qkevinto/pen/GpQZXN
require "./main.scss"

_= require "underscore"
MAX_RADIUS = 100
GAP        = 10
PADDING    = 25
HEIGHT     = (MAX_RADIUS + PADDING) * 2
WIDTH      = (MAX_RADIUS + PADDING) * 2
CSS_CLASS  = "rings"
RING_CSS_CLASS = "ring"

randomData= [
  [34, 100]
  [21, 100]
  [43, 121]
  [35, 120]
  [35, 520]
  [13, 420]
  [31, 420]
  [15, 21]
  [35, 340]
  [35, 340]
]
# HELPERS
_setAttrs= (target, attrs)->
  _.inject attrs, (memo, value, key)->
    memo.attr(key, value)
  , target
_randomDirection= ->
  if Math.floor(Math.random() * 11) % 2 is 0 then "-" else ""


document.addEventListener "DOMContentLoaded", ->

  dataset= _.map randomData, (item)->_.object  ["value", "total"], item

  svg= _setAttrs d3.select("body").append("svg"),
    height: HEIGHT, width : WIDTH
    class : CSS_CLASS

  rings= _setAttrs svg.selectAll("circle").data(dataset).enter().append("circle"),
    cx: WIDTH / 2, cy: HEIGHT / 2
    fill: "none", class : RING_CSS_CLASS

  rings.each (d, i)->
    radius= MAX_RADIUS - (GAP * i)
    length= Math.PI * (radius * 2)
    value= (d.value/d.total) * length
    _setAttrs d3.select(@),
      "r"                  : radius
      "stroke-dasharray"  : length
      "stroke-dashoffset" : length
    .transition()
    .duration(2000)
    .attr "stroke-dashoffset", value

  rotate= (el)->
    # el.transform "r0, #{WIDTH / 2}, #{HEIGHT / 2}"
    valueTf= "r#{_randomDirection()}360, #{WIDTH / 2}, #{HEIGHT / 2}"
    duration= (Math.random() * 1000) + 2000
    easing= mina.linear
    el.animate transform: valueTf, duration, easing, ->rotate(el)
    el.animate transform: valueTf, duration, easing
  rings.each -> rotate Snap(@)
