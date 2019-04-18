<template lang="pug">
  #top(style="position:fixed;width:100%;height:100%;background:#000;display:flex;justify-content: center;align-items: center;")
    #knossos(style="width:70vw;z-index:3;")
      include One/knossos.svg
    #cosmos
    #chaos
      svg(viewBox="0 0 58 58")
        g(filter="url(#filter-chaos)")
          circle(cx="29" cy="29" r="15")
          animateMotion(
            dur="30s" fill="freeze" rotate="auto"
          ): mpath(xlink:href="#")
        defs
          filter#filter-chaos(
            x="0" y="0" width="58" height="58"
            filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB"
          )
            feFlood(flood-opacity="0" result="BackgroundImageFix")
            feBlend(mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape")
            feGaussianBlur(stdDeviation="7" result="effect1_foregroundBlur")
              animate#animateChaos1(
                attributeType="XML" attributeName="stdDeviation"
                from=7 to=2 dur="1200ms" begin="0ms;animateChaos2.end"
              )
              animate#animateChaos2(
                attributeType="XML" attributeName="stdDeviation"
                from=2 to=7 dur="1200ms" begin="1200ms;animateChaos1.end"
              )
</template>
<style lang="scss">
  #cosmos{
    z-index: 1;
    position: absolute;width:100%;height:100%;
    background: lighten(#030311, 3%);
  }
  #chaos{
    z-index: 2;
    position: absolute;width:100%;height:100%;
    display: flex;justify-content: center;align-items: center;
    svg{width: 13rem;height: 13rem; fill: #7A280E;}
  }
</style>
