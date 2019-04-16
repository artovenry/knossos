<template lang="pug">
  path(:stroke-dasharray="length"  :stroke-dashoffset="animate ? length : 0")
    animate(v-if="animate != false"  attributeName="stroke-dashoffset"  :from="length"  to="0"  :dur="dur"  :begin="begin"  :fill="fill")
</template>
<script lang="coffee">
  export default
    props:["dur", "fill", "begin", "animate"]
    data: -> length: 0
    mounted: ->if not @animate then @length=@$el.getTotalLength()
</script>
