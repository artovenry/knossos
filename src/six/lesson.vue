<template lang="pug">
  #design5
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:1rem;")
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;border: 1px solid #AAA;")
        path(stroke="#CCC" d="m 0 400 h 1600")
        path(stroke="#CCC" d="m 800 0 v 800")
        g(transform="scale(16) translate(50 47) scale(1, -1)")
          g(stroke="#333" fill="none" stroke-width=".125" transform="translate(0 22)")
            path(d="m8+8h-16v-16h+16v+16")
            path(d="m0+8l8-8")
            path(d="m-8+0l8-8")
            path(:d="d1(8, 45)")
            path(:d="d4(8, 90)")
            path(:d="d2(8, 45)")
            path(:d="d7(8, 120)"  :stroke-dasharray="len(8, 120)"  :stroke-dashoffset="len(8, 120)")
              animate(attributeName="stroke-dashoffset"  :from="len(8, 120)"  :to="0" dur="1s"  fill="freeze")
            path(:d="d5(8, 45)")
            path(:d="d8(8, 60)")
            path(:d="d3(8, 90)" stroke="red")
            path(:d="d6(8, 90)" stroke="green")
</template>
<script lang="coffee">
  arc= (r, type, theta)->
    leftClock= [1, 0, 1 ,0, 1, 0, 1 ,0][type - 1]
    rad= (if leftClock is 0 then -1 else 1) * 2*Math.PI * Math.abs(theta) /360
    longArc= if Math.abs(theta) <=180 then 0 else 1
    rsin= r*Math.sin(rad);rcos=r*Math.cos(rad);
    [dx, dy]= switch type
      when 1 then [rsin, r - rcos]
      when 2 then [r - rcos, -rsin]
      when 3 then [rcos - r, rsin]
      when 4 then [rsin, r - rcos]
      when 5 then [-rsin, rcos - r]
      when 6 then [rcos - r, rsin]
      when 7 then [r - rcos, -rsin]
      when 8 then [-rsin, rcos - r]
    "a #{r} #{r} 0 #{longArc} #{leftClock} #{dx} #{dy}"

  draw= (number)-> (r, theta)->
    "m0-0 #{arc(r, number, theta)}"
  draws= methods: _.inject _.range(1, 10), (memo,number)->
    _.extend memo,
      "d#{number}" : draw(number)
  , {}
  export default
    components:{}
    mixins: [draws]
    methods:
      len: (r, theta)-> 2 * r * Math.PI * theta / 360
</script>
