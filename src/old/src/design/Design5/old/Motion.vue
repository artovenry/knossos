<template lang="pug">
  animateMotion(
    :path="path"
    :begin="startAt"
    :dur="dur+'s'"
    fill="freeze"
    rotate="auto"
  )
</template>
<script lang="coffee">
  NOOP= "noop"
  export default
    props:
      type: default: "l"
      begin: default: "auto"
      dur: default: 1
      c: default: ""
    computed:
      path: ->
        "m 0 0 10 10"
      startAt: ->
        if _.isNumber(@begin)
          "#{@begin}s"
        else if _.isString(@begin)
          "#{@begin}.end"
        else
          NOOP
</script>
