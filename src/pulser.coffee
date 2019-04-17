import Vue from "vue/dist/vue.esm.js"
import {design_1 as design} from "./pulser/Top/designs"
vueOption=
  el: "#v-app"
  mounted: ->
    do ANIM= ->requestAnimationFrame(ANIM) if TWEEN.update()
  mixins: [design]
  computed: do ->
    alphyed= (target)->Color(target.color).setAlpha(target.alpha).toString()
    styleScreen: ->
      "background-color": alphyed(@screen)
    stylePulser: ->
      "stroke": @pulser.color
      "stroke-width": @pulser.width
    styleSpannko: ->
      "fill": alphyed(@spannko)
      "stroke-width": @spannko.width
    styleSwitch: ->

  methods:
    show: (ref)->@$refs[ref].classList.remove "invisible"
    styleRayOf: (index, deltaX, deltaY)->
      ORIGIN= x: 174, y: 218
      quadrant= do->
        if deltaX >= ORIGIN.x
          if deltaY < ORIGIN.y then 0 else 3
        else
          if deltaY < ORIGIN.y then 1 else 2

      origin= switch quadrant
        when 0 then "0px #{ORIGIN.y - deltaY}px"
        when 1 then "#{ORIGIN.x - deltaX}px #{ORIGIN.y - deltaY}px"
        when 2 then "#{ORIGIN.x - deltaX}px #{deltaY - ORIGIN.y}px"
        when 3 then "#{deltaX - ORIGIN.x}px #{deltaY - ORIGIN.y}px"

      transform= "translate(#{deltaX}px, #{deltaY}px) scale(#{@pulser.rays[index].scale})"
      return "transform: #{transform}; transform-origin: #{origin};"

document.addEventListener "DOMContentLoaded", -> new Vue vueOption
