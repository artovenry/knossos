<template lang="pug">
  //- DrawPath(
  //-   :animate="false"
  //-   v-bind="drawPath"
  //- )
  //-   DrawMotionPath(
  //-     :path="motionPath"
  //-   )
  animateMotion(
    v-if="animate"
    :dur="dur + 'ms'"
    :path="draw(path)"
    rotate="auto"
    fill="freeze"
    :begin="startAt(begin)"
  )
</template>
<script lang="coffee">
  import mixins from "./mixins"
  export default
    mixins: [mixins]
    props:
      begin: default: 0
      dur: default: 1000
      path: default: ->[]
    data: ->relative: yes
    methods:
      startAt: (begin)->
        if begin?
          if _.isNumber(begin) then "#{begin}ms"
          else if _.isString(begin) then "#{@$store.state.tags[begin]}.begin"
        else "0ms"
</script>
