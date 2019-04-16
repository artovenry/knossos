<template lang="pug">
  include mixinYoyo.pug
  svg#ariadne(viewBox="0 0 3200 1800")
    path#ariadneString(:d="ariadneString" stroke-width="0" fill="none")
    template(v-if="$store.getters.activeAriadne")
      circle#ariadne(opacity=0  :cx=0  :cy=0 r=29 fill="#990000" stroke="none" filter="url(#filter-ariadne)")
        animate(attributeType="XML" attributeName="opacity" from=0 to=1 dur="1ms" fill="freeze")
        animateMotion#ariadneMotion(dur="63000ms" fill="freeze" rotate=auto)
          mpath(xlink:href="#ariadneString")
        +yoyo("r", 12, 29, "1300ms")

    defs
      filter#filter-ariadne(filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB")
        feGaussianBlur(stdDeviation="9"): +yoyo("stdDeviation", 13, 2, "1300ms")
</template>
<script lang="coffee">
  import paths from "./labyrinthPaths"
  import {KNOSSOS_ORIGIN, RATIO} from "./constants"
  export default
    data: ->
      ratio: RATIO
      origin: KNOSSOS_ORIGIN
      ariadneString: paths().ariadne
</script>
