<template lang="pug">
  #design52
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:0rem;")
      svg(@click="pause"  viewBox="0 0 1600 800" width="1600px" style="width: 95vw;height:100vh;border: 0px solid #AAA;")
        path(stroke="#666" d="m 0 400 h 1600")
        path(stroke="#666" d="m 800 0 v 800")
        g(:transform="globalTransform")
          -var rad= 1 / 180 * Math.PI
          -var sin= function(r, theta){return r*Math.sin(theta*rad)}
          -var cos= function(r, theta){return r*Math.cos(theta*rad)}

          g.main(fill="none"  stroke-linecap="square"  :stroke-width="2 / scale")
            animateTransform(titie="上昇"  v-if="joushou"
              id="tag_rotate_2"
              attributeName="transform"
              type="translate" fill="freeze"
              begin="kaiten.begin+2s" dur="15s"
              from="0 0"  to="0 14"
              calcMode="spline"
              keyTimes="0;1"  keySplines="0.13 -0.17 0.13 -0.17"
            )
            animate(title="拡大2"
              attributeName="stroke-width" fill="freeze" calcMode="spline"
              begin="TAG_A_draw.end" dur="37s"
              :from="2 / scale"  :to="2 / scale / 1.5"
              keyTimes="0;1"  keySplines="0.13 -0.07 0.13 -0.07"
            )
            g
              circle(title="ミノタウロス" v-if="true"  cx="0"  cy="0"  :r="4/scale"  fill="red"    :visibility="minoBlink ? 'hidden'  : 'visible'")
                animate(title="点滅" v-if="minoBlink"
                  attributeName="visibility"
                  fill="freeze"
                  begin="TAG_A_draw.end"  dur="100ms"
                  values="hidden; visible; visible"
                  keyTimes="0; .5; 1"
                  repeatCount="10"
                )
              animateTransform#kaiten(
                title="回転" v-if="kaiten"
                attributeName="transform" type="rotate" fill="freeze"
                calcMode="spline"
                begin="TAG_A_draw.end" dur="37s"
                from="0 0 0"  to="-360 0 0"
                keyTimes="0;1"  keySplines=".11 -0.33 .44 1"
              )
              animateTransform(title="拡大"
                attributeName="transform" type="scale" fill="freeze" calcMode="spline"
                begin="TAG_A_draw.end" dur="37s"
                from="1"  to="1.5"
                keyTimes="0;1"  keySplines="0.13 -0.07 0.13 -0.07"
                additive="sum"
              )
              d(c="1 -8 l 0 4"  t=0  dt=4)
                //- d(c="l 0 4"   dt=3   keySplines=".05,.29,.91,.91")
                //-   d(c="c 1 3 180|c 2 6 180" dt=4)
                d(c="l 0 4|c 1 3 180|c 2 6 180"   dt=7   keySplines=".05,.29,.91,.91")
                d(c="l 4 0|c 4 1 90|c 9 3 120"   dt=7   keySplines=".05,.29,.91,.91")
                d(title="一番中心" tag="TAG_A"  c="l -4 0|c 4 4 90|c 2 2 180" dt=7 keySplines=".05,.29,.11,.11")
                  //- モーションするところだけ消す
                  animate(from="0" begin="TAG_A_draw.end"
                    to=Math.PI*2
                    dur="100ms" slot="animations" attributeName="stroke-dashoffset" fill="freeze"
                  )


              g(transform="translate(1 -4)")
                d#center(t="kaiten.end" dt=2  :animate="false"  c="0 4 c 4 7 90|c 4 5 90|c 4 3 90|c 4 1 90")
                  animateTransform(
                    slot="animations"
                    attributeName="transform" type="scale" fill="freeze"
                    from="0"  to="1"
                    begin="kaiten.end"  dur="2s"
                  )
                  animate(
                    slot="animations"
                    attributeName="stroke-width" fill="freeze"  calcMode="discrete"
                    from="0"  :to="2 / scale"
                    begin="kaiten.end"  dur="2s"
                  )
              d(t="TAG_A_draw.end" dt=37 c="-3 0 c 3 2 180" keySplines=".05,.70,.91,.91")
              d(t="TAG_A_draw.end" dt=37 c="-5 0 c 5 2 180" keySplines=".05,.70,.91,.91")
              d(t="TAG_A_draw.end" dt=37 c="-7 0 c 7 2 180" keySplines=".05,.70,.91,.91")
              circle(v-if="false" cx=-3 cy=0 :r="4/scale"  fill="blue"  visibility="hidden")
                animate(
                  attributeName="visibility" fill="freeze"
                  begin="TAG_A_draw.end"  dur="1ms" values="hidden; visible"  calcMode="discrete"
                )

              m(
                t="TAG_A_draw.end"
                dt=37 c="-3 0 c 3 2 180"
                keySplines=".05,.70,.91,.91"
              )
                d(c="0 4 c 2 8 180"  :animate="false")
                circle(v-if="false" cx=0 cy=2 :r="4/scale"  fill="blue"  visibility="hidden")
                  animate(
                    attributeName="visibility" fill="freeze"
                    begin="TAG_A_draw.end"  dur="1ms" values="hidden; visible"  calcMode="discrete"
                  )


              //- この二つは結合
              d(t="TAG_A_draw.end" transform=`rotate(120 ${cos(9, 120)} ${sin(9, 120)})` dt=7 c=`${cos(9, 120)} ${sin(9, 120)} c 9 3 60`)
              d(tag="TAG_L" t="TAG_A_draw.end+7" dt=12 c="-9 0 c 6 7 90"  keySplines=".82,.75,.96,.87")
                d(c="c 2 8 180" dt=3  keySplines=".05,.29,.91,.91")
                  d(tag="TAG_B"  c="c 10 4 90|c 13 2 180|c 8 6 90" dt=15  keySplines=".35,0,.38,.98")
              //- TAG_LとTAG_Rは出会わなくてはならない
              d(tag="TAG_R" t="TAG_A_draw.end+4"  dt=15 c="-3 -8 c 8 4 90|c 11 2 180|c 6 6 90"  keySplines=".08,.67,.61,.54")
                d(c="c 2 5 180" dt=3  keySplines=".05,.29,.91,.91")
                  d(c="c 10 1 90|c 15 3 180|c 12 7 90|c 4 1 90" dt=15  keySplines=".35,0,.38,.98")


              circle(v-if="false"  cx=-3 cy=-8 :r="4/scale"  fill="blue"  visibility="hidden")
                animate(
                  attributeName="visibility" fill="freeze"
                  begin="TAG_A_draw.end+4"  dur="1ms" values="hidden; visible"  calcMode="discrete"
                )
              circle(v-if="false" cx=5 cy=-8 :r="4/scale"  fill="blue"  visibility="hidden")
                animate(
                  attributeName="visibility" fill="freeze"
                  begin="TAG_B_draw.end"  dur="1ms" values="hidden; visible"  calcMode="discrete"
                )

</template>
<style lang="scss" scoped>
  /* html, body, #design52, #top{
    background: darken(#050620, 4%);
  }
  #center{fill: darken(#050620, 4%);}
  .main{
    stroke: #888;
  } */
  html, body, #design52, #top{
    background: #FFF;
  }
  #center{fill: #FFF;}
  .main{
    stroke: #333;
  }
</style>
<script lang="coffee">
  import Draw from "./Draw"
  import {Motion} from "./Draw"
  export default
    components: {d:Draw, m: Motion}
    data: ->
      scale: 16
      origin: x: 49, y: 39 #ミノタウロスの位置
      fastForward: 1 #早送りモード
      joushou: on
      minoBlink: on
      kaiten: on
    computed:
      globalTransform: ->
        "scale(#{@scale}) translate(#{@origin.x + 1} #{@origin.y}) scale(1, -1)"
    methods:
      pause: ->
    mounted: ->
      do fastFoward= =>
        document.querySelectorAll("*").forEach (el)=>
          if dur= el.getAttribute("dur")
            el.setAttribute "dur" , do (dur)=>
              [dt, unit]= dur.match(/^([\.0-9]+)(m?s)$/)[1..]
              "#{dt/@fastForward}#{unit}"
</script>
