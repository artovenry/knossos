<template>
  <path
    :stroke-dasharray="length"
    :stroke-dashoffset="animate ? length : 0"
  >
    <animate
      v-if="animate"
      attributeName="stroke-dashoffset"
      :from="length" to="0"
      :dur="dur + 'ms'"
      :begin="startAt(begin)"  fill="freeze"
      :id="tag"
      :fill="fill"
    />
    <slot />
  </path>
</template>
<script lang="coffee">
  export default
    props:
      dur: default: 1000
      begin: default: null
      animate: default: true
      tag: default: null
      fill: default: "freeze"
    data: ->length: 0
    mounted: ->
      if @animate then @length= @$el.getTotalLength()
    methods:
      startAt: (begin)->
        if begin?
          if _.isNumber(begin) then "#{begin}ms"
          else if _.isString(begin) then "#{begin}.end"
        # else if index isnt 0 then "#{@frames[index - 1].animationId}.end"
        else "0ms"
</script>
