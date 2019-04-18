<template lang="pug">
  include mixinYoyo.pug
  svg#thumele(viewBox="0 0 3200 1800")
    circle(
      opacity=1
      filter="url(#filter-thumele)"
      :cx="origin.x"
      :cy="origin.y"
      r=58
      fill_="#05051e"
      fill="#AAA"
    )
      +yoyo("r", 38, 58, "2200ms")
    defs
      filter#filter-thumele(filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB")
        feGaussianBlur(stdDeviation="25"): +yoyo("stdDeviation", 25, 15, "2200ms")
</template>
<script lang="coffee">
  import {KNOSSOS_ORIGIN} from "./constants"
  export default
    data: ->origin: KNOSSOS_ORIGIN
</script>
