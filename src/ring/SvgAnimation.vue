<template lang="pug">
  svg#app(viewBox="0 0 64 64")
    line(x1=32 y1=0  x2=32 y2=64 stroke="#000" stroke-width="0.125")
    line(x1=0  y1=32 x2=64 y2=32 stroke="#000" stroke-width="0.125")
    path#circle(
      d="M32 12 A 20 20 0 1 1 32 52 A 20 20 0 1 1 32 12"
      fill="none"
      stroke-width=2
      stroke="#AA0000"
      stroke-dasharray="125.66"
      stroke-dashoffset="125.66"
    )
      animate(
        attributeType="XML" attributeName="stroke-dashoffset"
        from="125.66" to="0" dur="5s" fill="freeze"
      )
    g#upper
      circle(fill="#AA0000" stroke="none" cx=0 cy=-6 r=2)
      line(stroke="#AA0000" x1= 0 y1= -6 x2= 0 y2= 10)
      animateMotion(dur="5s" fill="freeze" rotate="auto"): mpath(xlink:href="#circle")

    g#lower(opacity=0)
      circle(fill="#AA0000" stroke="none" cx= 32 cy= 30 r= 2)
      line(stroke="#AA0000" x1= 32 y1= 30 x2= 32 y2= 42)
      animate(
        attributeType="XML" attributeName="opacity"
        from=0 to=1 dur="1s" begin="4s" fill="freeze"
      )
      animateTransform(
        attributeType="XML" attributeName="transform" type="translate"
        from="0 -32" to="0 0" dur="1s" begin="4s" fill="freeze"
      )
</template>
<style lang="scss">
  body{margin:0;padding: 0;background:#DDD;}
  svg#app{background: #EEE;width:90vw;}
</style>
