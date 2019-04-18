<template lang="pug">
  g#nekko(:transform="rotateOrigin|transform")
    filter#filterNekko(filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"): feGaussianBlur(stdDeviation="3")
    g
      g(:transform="rotateOrigin|transform(true)" stroke-width="1" stroke-linecap="square" filter="url(#filterNekko)")
        path(fill="none" stroke="#EEE")
          animate#nekkoAnimationPrimary(attributeName="d"  :from="draw(from.cmds)"  :to="draw(to.cmds)"  :dur="dur[0]|ms"  fill="freeze"  :begin="tk.begin|ms")
        g(stroke="#EEE" fill="none")
          DrawPath(:d="draw(left.cmds)"  :animate="false"  :dur="dur[1]|ms"  fill="freeze" begin="nekkoAnimationPrimary.end")
          DrawPath(:d="draw(right.cmds)"  :animate="false"  :dur="dur[1]|ms"  fill="freeze" begin="nekkoAnimationPrimary.end")
          DrawPath(:d="draw(bottom.cmds)"  :animate="false"  :dur="dur[1]|ms"  fill="freeze" begin="nekkoAnimationPrimary.end")
      animateTransform(attributeName="transform" type="rotate" from="0" to="360" dur="10s" begin="nekkoAnimationPrimary.end + 2000ms" repeatCount="indefinite")
      //- animateTransform(attributeName="transform" type="scale" values="1;1.5;0.6;1"  dur="10s" begin="nekkoAnimationPrimary.end + 2000ms" repeatCount="indefinite"  additive="sum")
</template>
<script lang="coffee">
  export default
    props: ["from", "to", "left", "right", "bottom", "tk", "rotateOrigin"]
    filters: transform: (rotateOrigin, negative= off)->
      [x,y]= [rotateOrigin.x * (if negative then -1 else 1), rotateOrigin.y * (if negative then -1 else 1)]
      "translate(#{x}, #{y})"
    data: ->
      total: @tk.dur
    methods: draw: (cmds)->@$parent.draw(cmds)
    computed:
      dur: ->[
        @total/ 6,
        @total*5/6
      ]
</script>
