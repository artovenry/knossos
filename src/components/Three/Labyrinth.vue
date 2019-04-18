<template lang="pug">
  svg#labyrinth
    path#labyrinthFromUpperLeft(
      stroke="#666" stroke-width=4
      fill="none"
      :d="ul.d"
      :stroke-dasharray="ul.length" :stroke-dashoffset="ul.length"
      opacity=1
      )
      animate(v-if="ul.animated"
        attributeType="XML"
        attributeName="stroke-dashoffset"
        :from="ul.length" to=0 dur="30000ms" fill="freeze"
      )
    path#labyrinthFromUpperRight(
      stroke="#666" stroke-width=4
      fill="none"
      :d="ur.d"
      :stroke-dasharray="ur.length" :stroke-dashoffset="ur.length"
      opacity=1
      )
      animate( v-if="ur.animated"
        attributeType="XML"
        attributeName="stroke-dashoffset"
        :from="ur.length" to=0 dur="30000ms" fill="freeze"
      )
</template>
<style lang="scss">
  #labyrinth{stroke: lighten(#030311, 85%);}
</style>
<script lang="coffee">
  import {TWELVE, UNIT, RATIO, KNOSSOS_ORIGIN} from "./constants"
  import paths from "./labyrinthPaths"
  export default
    mounted: ->
      if @ul.animated
        @ul.length= document.querySelector("#labyrinthFromUpperLeft").getTotalLength()
      if @ur.animated
        @ur.length= document.querySelector("#labyrinthFromUpperRight").getTotalLength()
    data: ->
      ul: d:paths().fromUpperLeft, length: 0, animated: no
      ur: d:paths().fromUpperRight, length: 0, animated: no
      # ariadne: draw: draw("ariadne")
</script>
