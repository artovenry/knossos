<template lang="pug">
  stroke(:d="d"  :dur="dur"  :begin="begin"  :tag="tag")
    slot
</template>
<script lang="coffee">
  import Stroke from "./Stroke.vue"
  export default
    components: {Stroke}
    props:
      c: default: "0 0 0 0"
      dur: default: 1
      begin: default: null
      tag: deault: null
    computed:
      d: ->
        values= @c.split(" ")
        "m #{values[0]} #{values[1]} l #{values[2]} #{values[3]}"
</script>
