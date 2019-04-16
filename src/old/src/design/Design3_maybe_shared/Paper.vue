<template>
  <g transform="translate(800, 400)">
    <path :d="
      m(-15, 0)+
      ar(10, 10, -10)
    "/>
    <path stroke="red" :d="
      m0 +
      ar(4,4,4)
    "/>
  </g>
</template>
<script lang="coffee">
  export default
    data: ->origin: {x:50, y:25}, unit: 16
    computed:
      m0: ->"m 0 0"
    methods:
      m: (x, y)->"m #{x * @unit} #{y * @unit}"
      ar: (r, x, y)->"a #{r * @unit} #{r * @unit} 0 0 1 #{x * @unit} #{y * @unit}"

</script>
