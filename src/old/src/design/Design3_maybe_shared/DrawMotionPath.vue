<template lang="pug">
  animateMotion(
    :animate="false"
    v-bind="drawPath"
  )

</template>
<script lang="coffee">
  export default
    props: ["begin", "path", "mpath"]
    computed:
      drawPath: -> frames: [{d:@path}]
      motionPath: -> @mpath
    methods: {}
    mounted: _.noop
</script>
