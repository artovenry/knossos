<template lang="pug">
  #design5
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:1rem;")
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;border: 1px solid #AAA;")
        path(stroke="#CCC" d="m 0 400 h 1600")
        path(stroke="#CCC" d="m 800 0 v 800")
        g(:transform="globalTransform")
          g(stroke="#333" fill="none"  :stroke-width="2 / scale")
            circle(cx="-1"  cy="8"  :r="4/scale"  fill="red")
            stroke-l(c="0 0 0 4"  :begin="0.8")
              stroke-l(c="0 4 0 4"  :dur="0.8")
                stroke-s(c="0 8 1 3")
                  stroke-s(c="-2 8 2 6")
              stroke-l(c="0 4 4 0"   :dur="0.8")
              stroke-l(c="0 4 -4 0"   :dur="0.8"   tag="birth")
            stroke-q(c="-4 4 4 4"  begin="birth"  :dur="0.8")
              stroke-s(c="-8 8 2 2")
                //- motion(slot="motion"  type="l"  begin="auto"  :dur="3"  c="-6 8 10 10")
            stroke-q(c="4 4 4 1"  begin="birth"  :dur="0.8")
</template>
<script lang="coffee">
  import Stroke from "./Design5/Stroke.vue"
  # import Motion from "./Design5/Motion.vue"
  StrokeL= _.extend Stroke, props: _.extend(Stroke.props, type: 'l')
  StrokeC= _.extend Stroke, props: _.extend(Stroke.props, type: 'c')
  # c="x, y, r, type"
  StrokeQ= _.extend StrokeC, computed: _.extend(StrokeC.computed, theta: ->90)
  # c="x, y, r, type"
  StrokeS= _.extend StrokeC, computed: _.extend(StrokeC.computed, theta: ->90)


  export default
    components:{Stroke, StrokeL, StrokeC, StrokeQ, StrokeS}
    data: ->
      scale: 16
      origin: x: 50, y: 47
    computed:
      globalTransform: ->
        "scale(#{@scale}) translate(#{@origin.x} #{@origin.y}) scale(1, -1)"
</script>
