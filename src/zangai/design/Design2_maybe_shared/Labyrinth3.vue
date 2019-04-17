<template lang="pug">
  #labyrinth
    svg(viewBox="0 0 1600 800" width="1600px" style="width: 100vw;height:100vh;")
      rect#background(x=0 y=0 width="100%" height="100%" fill="black")
      circle#minotauros(:cx="minotauros.x"  :cy="minotauros.y"  :r=2  fill="red")
      path#ariadneString(:d="draw(ariadneString)|append(ariadneTail)" stroke="yellow" opacity=1)
      circle#ariadne(:cx="minotauros.x"  :cy="minotauros.y" r=4  fill="red" opacity="0")
        animate(attributeName="opacity" from=0 to=1  dur="100ms"  :begin="tk.ariadne.begin|ms"  fill="freeze")
        animateMotion(:path="animateAriadne(ariadneString)|append(ariadneTail)"  :dur="tk.ariadne.dur|ms"  :begin="tk.ariadne.begin|ms" fill="freeze")
      path.upperleft(fill="none" stroke="white" opacity="1"  :d="draw(upperleft)")
        animate(attributeName="d"  :from="draw(upperleft)"  :to="draw(tangle(upperleft))" dur="30000ms" fill="freeze")
      path.upperright(fill="none" stroke="white"  :d="draw(upperright)")
        animate(attributeName="d"  :from="draw(upperright)"  :to="draw(tangle(upperright))" dur="30000ms" fill="freeze")
      circle#heart(:cx="minotauros.x"  :cy="minotauros.y" fill="white" opacity="1" filter="url(#filterHeart)")
        animate(attributeName="r" values="8;12;8" dur="4000ms" repeatCount="indefinite")
      filter#filterHeart(filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"): feGaussianBlur(stdDeviation="7")
      Nekko(v-bind="nekko"  :tk="tk.nekko"  :rotateOrigin="minotauros")
      circle(:cx="ORIGIN.x"  :cy="ORIGIN.y"  :r=2  fill="red")
      rect#centerCube(:x="ORIGIN.x -4 * UNIT"  :y="ORIGIN.y -4 * UNIT"  :width="8 * UNIT"  :height="8 * UNIT" stroke="red" opacity="1" fill="none")
      //- g#orquestra(fill="white")
      //-   path#orq-o(:d="orquestra.o.d")
      //-   path#orq-r1(:d="orquestra.r1.d")
      //-   path#orq-c(:d="orquestra.c.d")
      //-   path#orq-h(:d="orquestra.h.d")
      //-   path#orq-s(:d="orquestra.s.d")
      //-   path#orq-t(:d="orquestra.t.d")
      //-   path#orq-r2(:d="orquestra.r2.d")
      //-   path#orq-a(:d="orquestra.a.d")
</template>
<style lang="scss">
  body{background: #000;}
</style>
<script lang="coffee">
  import Vue from "vue"
  import Nekko from "./Labyrinth3/Nekko.vue"
  import DrawPath from "./Labyrinth3/DrawPath.vue"
  import data from "./Labyrinth3/data.coffee"
  import {Move, A, Line} from "./Labyrinth3/constants"
  import orquestra from "./orquestra"

  Vue.component "DrawPath", DrawPath
  Vue.filter "ms", (arg)->"#{arg}ms"
  Vue.filter "append", (arg, str)->"#{arg} #{str}"
  Vue.filter "prepend", (arg, str)->"#{str} #{arg}"
  export default
    components: {Nekko}
    # mounted: ->@$el.addEventListener "click", =>@$el.webkitRequestFullScreen()
    mixins: [data]
    data: ->
      ORIGIN: x:800, y:400
      UNIT: 16
      SOUND_OFFSET: 1500
    computed:
      orquestra: ->
        _.mapObject orquestra, (item)->
          d: "M 800 400 " + item.d
      tk: ->
        ariadne: begin: @SOUND_OFFSET + 29.700, dur: 66900
        nekko: begin: @SOUND_OFFSET + 29.700 + 66900, dur: 24100
      minotauros: ->x: @ORIGIN.x - 1 * @UNIT, y: @ORIGIN.y - 4 * @UNIT
      ariadneTail: ->"a #{32 * @UNIT} #{36 * @UNIT} 0 0 0 #{32 * @UNIT} #{-36 * @UNIT}"

    methods:
      _data2cmd: (cmds)->
        _.inject cmds, (memo, data)=>
          str= if _.isString data then data  else
            scaled= _.map data[1], (item)=>item * @UNIT
            switch data[0]
              when Move then "m #{scaled[0]} #{scaled[1]}"
              when Line then "l #{scaled[0]} #{scaled[1]}"
              when A    then "a #{scaled[0]} #{scaled[0]} 0 0 #{data[2]} #{scaled[1]} #{scaled[2]}"
          _.compact([memo, str]).join " "
        , ""

      animateAriadne:  (cmds)->
        cmds= _.clone(cmds);cmds.shift();
        "m 0 0 #{@_data2cmd(cmds)}"

      draw: (cmds, origin=true)->
        leading= "M #{@ORIGIN.x} #{@ORIGIN.y}"
        if origin then "#{leading} #{@_data2cmd(cmds)}" else @_data2cmd(cmds)
      tangle: (data)->
        _.map data, (item)->
          return item if item[0] isnt A
          if _.random(0,1)
            [A, [item[1][0], -item[1][1], -item[1][2]], +!item[2]]
          else item
</script>
