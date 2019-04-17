<template lang="pug">
  #design52
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:1rem;")
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;border: 1px solid #AAA;")
        path(stroke="#CCC" d="m 0 400 h 1600")
        path(stroke="#CCC" d="m 800 0 v 800")
        g(:transform="globalTransform")

          g(stroke="#333" fill="none"  :stroke-width="2 / scale")
            circle(cx="-1"  cy="8"  :r="4/scale"  fill="red")

            d(c="0 0 l 0 4"  begin=0)
              d(c="l 0 4")
                d(c="c 1 3 180")
                  d(c="c 2 6 180")
              d(c="l 4 0")
                d(c="c 4 1 90")
                  d(c="c 2 3 180")
              d(c="l -4 0")
                d(c="c 4 4 90")
                  mixin toggle(slot, state, begin)
                    animate(slot=slot  attributeName="visibility" from=`${state ? 'hidden' : 'visible'}`  to=`${state ? 'visible' : 'hidden'}`  dur="1ms"  begin=begin fill="freeze")

                  //- この図形は、モーションする図形の前段階の図形
                  d(c="c 2 2 180"  tag="motion1")
                    //- 終わったらすぐさま消える
                    +toggle("animation1", false, "draw_motion1.end")

                  //- モーションと同じ動きをする図形群
                  d(c="c 6 2 90" dur=3  begin="motion_motion2.begin")
                  d(c="2 0 c 4 2 90" dur=3  begin="motion_motion2.begin")
                  d(c="4 0 c 2 2 90" dur=3  begin="motion_motion2.begin")


                  //- これがモーションパス
                  d(c="2 0 c 4 2 90"  tag="mpath1"  :animate="false"  :visibility="false")
                  //- motionする図形は沿うパスと同じ階層にいないと分かりにくくなる
                  //- また、モーションする図形は、沿うパスによって決まる座標系に属する！
                  //- また、このモーションは、親ドローアニメーションから起動しないので、beginを明示する必要がある
                  d(c="0 2 c 2 8 180"  :visibility="false"  :animate="false" tag="motion2"   :motion="{path: '#path_mpath1', dur: 3, fill:'freeze', begin:'draw_motion1.end'}")
                    //- 始まるや否や姿を現す
                    +toggle("animation1", true, "draw_motion1.end")




</template>
<script lang="coffee">
  import Draw from "./Draw.vue"
  export default
    components: {d:Draw}
    data: ->
      scale: 16
      origin: x: 50, y: 47
    computed:
      globalTransform: ->
        "scale(#{@scale}) translate(#{@origin.x} #{@origin.y}) scale(1, -1)"
</script>
