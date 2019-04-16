<template lang="pug">
  stroke(:d="d"  :dur="dur"  :begin="begin"  :tag="tag")
    slot(name="motion"  slot="motion")
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
        R= 0;L= 1
        [x, y, r, type]= @c.split(" ")
        diam= 2 * r
        rdiam= 2 * -r
        c= switch +type
          when 1 then [L,  0,  diam]
          when 2 then [R,  diam,  0]
          when 3 then [L, -diam, 0]
          when 4 then [R, 0, diam]
          when 5 then [L, 0, -diam]
          when 6 then [R, -diam, 0]
          when 7 then [L, diam, 0]
          when 8 then [R, 0, -diam]

        "m #{x} #{y} a #{r} #{r} 0 0 #{c[0]} #{c[1]} #{c[2]}"
</script>
