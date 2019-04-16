<template lang="pug">
  #design52
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:0rem;")
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;height:100vh;border: 0px solid #AAA;")
        //- path(stroke="#CCC" d="m 0 400 h 1600")
        //- path(stroke="#CCC" d="m 800 0 v 800")
        g(:transform="globalTransform")

          g.main(fill="none"  stroke-linecap="square"  :stroke-width="2.5 / scale")
            animateTransform(titie="上昇"  v-if="joushou"
              id="tag_rotate_2"
              attributeName="transform"
              type="translate" fill="freeze"
              begin="tag_rotate_1.begin+2s" dur="15s"
              from="0 0"  to="0 15"
              calcMode="spline"
              keyTimes="0;1"  keySplines="0.13 -0.17 0.13 -0.17"
            )
            //- ミノタウロス
            circle(cx="-1"  cy="8"  :r="4/scale"  fill="red"    :visibility="minoBlink ? 'hidden'  : 'visible'")
              animate(title="点滅" v-if="minoBlink"
                attributeName="visibility"
                fill="freeze"
                begin="tag2_motion.begin-200ms"  dur="100ms"
                values="hidden; visible; visible"
                keyTimes="0; .5; 1"
                repeatCount="10"
              )
            g
              animateTransform(title="回転" v-if="kaiten"
                attributeName="transform" type="rotate" fill="freeze" id="tag_rotate_1" calcMode="spline"
                begin="tag2_motion.begin+1s" dur="20s"
                from="0 -1 8"  to="-180 -1 8"
                /* keyTimes="0;1"  keySplines="0.13 -0.07 0.13 -0.07" */
                keyTimes="0;1"  keySplines="0.13 -0.07 0.13 -0.07"
              )
              d(c="0 0 l 0 4"  t=0  dt=2)
                d(c="l 0 4"   dt=2)
                  d(c="c 1 3 180" dt=2)
                    d(c="c 2 6 180"   dt=2)
                d(c="l 4 0"   dt=2)
                  d(c="c 4 1 90"  dt=2)
                    d(tag="tag3" c="c 9 3 180"  dt=6)
                      m(tag="tag6m" c="c 6 7 90"  t="tag6_draw.end"  dt=20)
                        d(c="c 2 8 180"  :animate="false")
                      d(c="-4 0 c 10 7 90"  dt=20  t="tag6_draw.end")
                      d(c="-2 0 c 8 7 90"  dt=20  t="tag6_draw.end")
                      d(c="0 0 c 6 7 90"  dt=20  t="tag6_draw.end")


                      d(tag="tag6"  c="c 2 6 180" dt=1  dFill="remove")
                        d(c="c 13 2 90" dt=10)
                        d(c="2 0 c 11 2 90" dt=10)
                          d(tag="tag4" dFill="remove" c="c 2 1 180")
                            d(c="c 15 5 90" dt=5)
                              d(c="c 12 7 90"  dt=5)
                                d(c="c 4 1 90"  dt=5)
                          m(tag="tag4m"  c="c 11 8 90"  t="tag4_draw.end"  dt=14  motionTransform="translate(0 0)")
                            d(c="c 2 1 180"  :animate="false")
                              animate(slot="animations"  begin="tag4m_motion.end" dur="1ms" attributeName="visibility" fill="freeze" from="visible" to="hidden")
                          m(tag="tag5m"  c="11 -11 c 6 6 90" t="tag4m_motion.end"  dt=14  motionTransform="translate(0 0)")
                            d(c="c 2 1 180"  :animate="false")
                          d(c="0 4 c 15 8 90"  dt=14  t="tag4_draw.end")
                            d(c="c 10 6 90"  dt=14)
                          d(c="0 2 c 13 8 90"  dt=14  t="tag4_draw.end")
                            d(c="c 8 6 90"  dt=14)
                          d(c="0 0 c 11 8 90"  dt=14  t="tag4_draw.end")
                            d(c="c 6 6 90"  dt=14)

                d(c="l -4 0"   dt=2)
                  d(c="c 4 4 90"  dt=2)
                    d(c="c 2 2 180"   dt=2 tag="tag1"  dFill="remove")
                    m(tag="tag2"  c="2 0 c 5 2 180"  dt=30  t="tag1_draw.end" motionTransform="translate(0 2) rotate(-90)")
                      d(c="c 2 2 180"  :animate="false")
                    d(c="c 7 2 180"  dt=30  t="tag1_draw.end" )
                    d(c="2 0 c 5 2 180"  dt=30  t="tag1_draw.end" )
                    d(c="4 0 c 3 2 180"  dt=30  t="tag1_draw.end" )
</template>
<style lang="scss" scoped>

  html, body, #design52, #top{
    background: darken(#050620, 4%);
  }
  .main{
    stroke: #888;
  }
</style>
<script lang="coffee">
  import Draw from "./Design53/Draw"
  import {Motion} from "./Design53/Draw"
  export default
    components: {d:Draw, m: Motion}
    data: ->
      scale: 16
      # origin: x: 50, y: 47 <----これがほんと
      origin: x: 50, y: 37
      fastForward: 1#早送りモード
      joushou: off
      minoBlink: off
      kaiten: off
    computed:
      globalTransform: ->
        "scale(#{@scale}) translate(#{@origin.x} #{@origin.y}) scale(1, -1)"
    mounted: ->
      do fastFoward= =>
        document.querySelectorAll("*").forEach (el)=>
          if dur= el.getAttribute("dur")
            el.setAttribute "dur" , do (dur)=>
              [dt, unit]= dur.match(/^([\.0-9]+)(m?s)$/)[1..]
              "#{dt/@fastForward}#{unit}"
</script>
