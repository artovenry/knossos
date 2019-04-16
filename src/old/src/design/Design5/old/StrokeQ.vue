<template lang="pug">
  stroke(:d="d"  :dur="dur"  :begin="begin"  :tag="tag")
    slot
</template>
<script lang="coffee">
  import Stroke from "./Stroke.vue"
  BEZ= 0.552284749831
  RBEZ= 1 - BEZ
  export default
    components: {Stroke}
    props:
      c: default: "0 0 0 0"
      dur: default: 1
      begin: default: null
      tag: deault: null
    computed:
      d: ->
        [x, y, r, type]= @c.split(" ")
        curve= switch +type
          when 1 then "c #{BEZ * r} 0    #{r} #{r * RBEZ}   #{r}  #{r}"
          when 2 then "c 0 #{BEZ * r}    #{r * RBEZ} #{r}   #{r}  #{r}"
          when 3 then "c 0 #{BEZ * r}   #{-r * RBEZ} #{r}  #{-r}  #{r}"
          when 4 then "c #{BEZ * -r} 0  #{-r} #{r * RBEZ}  #{-r}  #{r}"
          when 5 then "c #{BEZ * -r} 0  #{-r} #{-r * RBEZ} #{-r} #{-r}"
          when 6 then "c 0 #{BEZ * -r}  #{-r * RBEZ} #{-r} #{-r} #{-r}"
          when 7 then "c 0 #{BEZ * -r}  #{r * RBEZ} #{-r}   #{r} #{-r}"
          when 8 then "c #{BEZ * r} 0   #{r} #{-r * RBEZ}   #{r} #{-r}"

        "m #{x} #{y} #{curve}"

</script>
