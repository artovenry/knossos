<template lang="pug">
  svg#teatoron(viewBox="0 0 3200 1800" fill="none" stroke-width=4.2 opacity=1)
    path(
      opacity=0
      v-for="(item, index) in radiations"
      :d="item.cmd"
      :id="'teatoronRadiation-' + index"
      :stroke-dasharray="item.length"
      :stroke-dashoffset="item.length"
    )
      animate(
        attributeType="XML" attributeName="stroke-dashoffset"  :from="item.length" to=0 dur="20000ms" fill="freeze"
      )
    path(
      v-for="(item, index) in circles"
      :d="item.cmd"
      :id="'teatoronCircle-' + index"
      :stroke-dasharray="item.length"
      :stroke-dashoffset="item.length"
    )
      animate(
        :id="'teatoronCircleAnimation' + index"
        attributeType="XML" attributeName="stroke-dashoffset" fill="freeze"
        :from="item.length" to=0
        :dur="item.animationDuration"
        :begin="item.animationStart"
      )
</template>
<style lang="scss">
  #teatoron path{stroke: darken(#FFF, 50%);}
</style>

<script lang="coffee">
  import {TWELVE, UNIT, RATIO, KNOSSOS_ORIGIN} from "./constants"
  odd= (i)->i % 2 is 1
  export default
    data: ->
      ORQUESTRA_SIZE= 7; COUNT= TWELVE - 2
      circles: do ->
        DURAION= 4000;
        for i in [1..TWELVE]
          radius= UNIT * RATIO * (ORQUESTRA_SIZE + 0.5 + i)
          cmd: do ->
            fromRight=
              dx: radius * Math.cos(Math.PI / COUNT), dy: radius * Math.sin(Math.PI / COUNT)
            if not odd(i)
              """
                M #{KNOSSOS_ORIGIN.x} #{KNOSSOS_ORIGIN.y}
                m -#{fromRight.dx} #{fromRight.dy}
                A #{radius} #{radius} 0 1 1 #{KNOSSOS_ORIGIN.x + fromRight.dx} #{KNOSSOS_ORIGIN.y + fromRight.dy}
              """
            else
              """
                M #{KNOSSOS_ORIGIN.x} #{KNOSSOS_ORIGIN.y}
                m #{fromRight.dx} #{fromRight.dy}
                A #{radius} #{radius} 0 1 0 #{KNOSSOS_ORIGIN.x - fromRight.dx} #{KNOSSOS_ORIGIN.y + fromRight.dy}
              """

          length: Math.PI * radius / COUNT * TWELVE
          animationStart: do ->
            if i is 1
              "0ms"
            else
              # # "teatoronCircleAnimation#{i-2}.end - #{100 * 0.75^(i-1)}ms"
              # "teatoronCircleAnimation#{i-2}.end"
              "#{4000 * (i - 1) * 0.45^(i-1)}ms"
          animationDuration: "#{4000 * 0.75^(i-1)}ms"
      radiations: do ->
        radius= UNIT * RATIO * (ORQUESTRA_SIZE + TWELVE + 0.5)
        for i in [-1..COUNT+1]
          cmd: """
            M #{KNOSSOS_ORIGIN.x} #{KNOSSOS_ORIGIN.y}
            l #{radius * Math.cos(Math.PI / COUNT  * i)} #{-1 * radius * Math.sin(Math.PI / COUNT  * i)}
          """
          length: radius
</script>
