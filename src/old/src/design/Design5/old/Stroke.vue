<template lang="pug">
  g
    path(
      :stroke-dasharray="length"
      :stroke-dashoffset="length"
      :d="d"
    )
      animate(
        attributeName="stroke-dashoffset"
        fill="freeze"
        :dur="dur + 's'"
        :begin="startAt"
        :id="tag"
        :from="length"  :to="0"
        @endEvent="startDescendentAnimations"
      )
      slot(name="motion")
    g
      slot
</template>
<script lang="coffee">
  NOOP= "noop"
  export default
    props:
      d: default: ""
      dur: default: 1
      begin: default: null
      tag: deault: null
    data: ->length: 0
    mounted:->@length= @$el.firstChild.getTotalLength()
    methods:
      startDescendentAnimations: ->
        if @$el.firstChild.lastChild.tagName.toLowerCase() is "animatemotion" then @$el.firstChild.lastChild.beginElement()
        _.each @$el.lastChild.children, (el)->
          if el.firstChild.firstChild.getAttribute("begin") is NOOP
            el.firstChild.firstChild.beginElement()
    computed:
      startAt: ->
        if _.isNumber(@begin)
          "#{@begin}s"
        else if _.isString(@begin)
          "#{@begin}.end"
        else
          NOOP
</script>
