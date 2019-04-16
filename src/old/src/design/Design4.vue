<template lang="pug">
  #design4
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:1rem;")
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;border: 1px solid #AAA;")
        g(:stroke-width="2/16" stroke="#333" fill="none" transform="scale(16)")
          g#motionTwo
            animateTransform(
              additive="sum"
              dur="3000ms" begin="8000ms" type="rotate" attributeName="transform"
              :from="[(origin.x -1)*unit, (origin.y - 18)*unit] |rotate(0)"  :to="[(origin.x -1)*unit, (origin.y - 18)*unit]|rotate(-90)" fill="freeze"
            )
            g#motionOne
              circle(:cx="(origin.x -1)*unit"  :cy="(origin.y - 8)*unit"  :r="4/16" fill="red")
              animateTransform(
                additive="sum"
                dur="5000ms" begin="3000ms" type="translate" attributeName="transform"
                from="0 0"  :to="[0, -10*unit]|translate"  fill="freeze"
              )
              animateTransform(
                additive="sum"
                dur="5000ms" begin="3000ms" type="rotate" attributeName="transform"
                :from="[(origin.x -1)*unit, (origin.y - 8)*unit] |rotate(0)"  :to="[(origin.x -1)*unit, (origin.y - 8)*unit]|rotate(180)" fill="freeze"
              )
              g#birth
                - total=3000; dur= [800, total - 800]; begin=[0, 800]
                StrokePath(:dur=dur[0]  :d="mo+l(0, -4)")
                //- upper
                StrokePath(:dur=dur[1]  :begin=begin[1]  :d="mo+m(0, -4)+l(0, -4)+al(1,-2,0)+ar(2, -4, 0)")
                //- left
                StrokePath(:dur=dur[1]  :begin=begin[1]  :d="mo+m(0, -4)+l(-4, 0)+ar(4,-4,-4)+ar(2, 4,0)")
                  //- 左の最後の上半分円弧は次にアニメートするから消える
                  animate(
                    attributeName="d"
                    :from="mo+m(0, -4)+l(-4, 0)+ar(4,-4,-4)+ar(2, 4,0)"
                    :to="mo+m(0, -4)+l(-4, 0)+ar(4,-4,-4)"
                    dur="1ms"   begin=`${total}ms` fill="freeze"
                  )
                //- right
                StrokePath(:dur=dur[1]  :begin=begin[1]  :d="mo+m(0, -4)+l(4, 0)+al(4,4,-4)")
              g#part2
                //- 一番外側 (TODO:最後のal(9, -18, 0)は途中まで！)
                StrokePath(:begin="3000"  :dur="5000"  :d="mo+m(8, -8)+al(9, -9*(1-cos(0.3)), -9*sin(0.3))")
                //- 左の右
                StrokePath(:begin="3000"  :dur="5000"  :d="mo+m(-4, -8)+ar(3, 3, -3)")
                //- 左の中央
                StrokePath(:begin="3000"  :dur="5000"  :d="mo+m(-6, -8)+ar(5, 5, -5)")
                //- 左の左
                StrokePath(:begin="3000"  :dur="5000"  :d="mo+m(-8, -8)+ar(7, 7, -7)")
                StrokePath(:animate="false")
                  animate(attributeName="d" dur="1ms"  begin="3000ms"
                    :from="m(0,-2)"  :to="m(0,-2)+ar(2, 0,4)"  fill="freeze"
                  )
                  animateMotion(
                    begin="3000ms"  dur="5000ms"
                    :path="mo+m(-6, -8)+ar(5, 5, -5)"
                    rotate="auto" fill="freeze"
                  )
            //- START: 8000
            g#part3
              StrokePath(:begin="8000"  :dur="3000"  :d="mo+m(-1, -18)+m(-9 * cos(0.3), 9 * sin(0.3)) + al(9, 9*(1+cos(0.3)), -9 * sin(0.3))")
        template(v-if="false")
          g(transform="rotate(0, 784, 336) translate(800, 400)" stroke-width=3 stroke="#990000" fill="none" opacity=.09)
            path(:d="m(-4,-4)+ar(3,6,0)+al(2,4,0)+al(7,-14,0)+al(4,4,4)+l(8,0)+al(4,4,-4)+al(9,-18,0)+al(6,6,6)+ar(2,0,4)+ar(10,-10,-10)+ar(13,26,0)+ar(8,-8,8)")
            path(:d="m(4,-4)+al(5,-10,0)+al(2,4,0)+ar(1,2,0)+l(0,8)+ar(4,-4,4)+ar(12,-12,-12)+ar(15,30,0)+ar(10,-10,10)+ar(2,0,-4)+al(6,6,-6)+al(11,-22,0)+al(8,8,8)")
          path(stroke="#CCC" d="m 0 400 h 1600")
          path(stroke="#CCC" d="m 800 0 v 800")
</template>
<script lang="coffee">
  import StrokePath from "./Design4/StrokePath.vue"
  export default
    filters:
      rotate: (origin, deg)->"#{deg} #{origin[0]} #{origin[1]}"
      translate: (delta)->"#{delta[0]} #{delta[1]}"
    components: {StrokePath}
    data: ->
      origin: {x:50, y:47}, unit: 1
      tk:
        birth: from: 0, to: 2500
    computed:
      m0: ->"m 0 0"
      mo: ->"m #{@origin.x * @unit} #{@origin.y * @unit}"
    methods:
      # pos: (xy)->{x: xy.x * @unit, y: xy.y * @unit}
      sin: (n)->Math.sin(n*Math.PI)
      cos: (n)->Math.cos(n*Math.PI)
      dur: (scene, ratioOrdur...)->
      begin: ()->
      m: (x, y)->"m #{x * @unit} #{y * @unit}"
      l: (x, y)->"l #{x * @unit} #{y * @unit}"
      ar: (r, x, y, ratio=1)->"a #{r * @unit} #{r * @unit} 0 0 1 #{x * @unit} #{y * @unit}"
      al: (r, x, y, ratio=1)->"a #{r * @unit} #{r * @unit} 0 0 0 #{x * @unit} #{y * @unit}"
</script>
