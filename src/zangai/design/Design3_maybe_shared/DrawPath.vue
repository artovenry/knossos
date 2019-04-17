<template lang="pug">
  g
    path(
      v-for="(frame, index) in frames"
      :d="draw(frame.d)"
      :stroke-dasharray="lengths[index]"
      :stroke-dashoffset="animate ? lengths[index] : 0"
    )
      animate(
        v-if="animate"
        attributeName="stroke-dashoffset"
        :from="lengths[index]" to="0"
        :dur="frame.dur ?  frame.dur + 'ms' : '1000ms'"
        :begin="startAt(frame.begin, index)"  fill="freeze"
        :id="frame.animationId"
      )
      slot
</template>
<script lang="coffee">
  import mixins from "./mixins"
  export default
    mixins: [mixins]
    props:
      frames: default: ->[]
      relative: default: yes
    data: ->lengths: _.map @frames, ->0
    methods:
      startAt: (begin, index)->
        if begin?
          if _.isNumber(begin) then "#{begin}ms"
          else if _.isString(begin) then "#{@$state.tags[begin]}.end"
        else if index isnt 0 then "#{@frames[index - 1].animationId}.end"
        else "0ms"
    mounted: ->
      return if not @animate
      _.each @$el.children, (el, index)=>
        @lengths.splice(index, 1, el.getTotalLength())
###
SCHEMA:
unit:
origin:
anmate:
frames: [
  {
    d: collection of commands
    dur: null or number
    begin: null or number or string
    animationId: unique ID(automatically generated)
    tag: (optional)
  }
]
###
</script>
