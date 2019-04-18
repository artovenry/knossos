<template lang="pug">
  g(:transform="motion ? motionTransform : ''")
    Draw(
      :d="d(drawType, cmd)"

      :id="tag|id('_path')"
      :stroke-dasharray="length"
      :stroke-dashoffset="animate ? length : 0"
    )
      animate(v-if="animate"
        ref="drawAnimation"
        :id="tag|id('_draw')"
        attributeName="stroke-dashoffset"
        :from="length"  :to="0"  :fill="dFill"
        :dur="dur + 's'"  :begin="beginAt(begin)"
        @endEvent="onEndDraw"
        @startEvent="onStartDraw"
      )
      Draw(v-if="motion"
        :d="motionOpt.path"

        ref="motionAnimation"
        :id="tag|id('_motion')"
        :fill="motionOpt.fill"  :rotate="motionOpt.freeze"
        :dur="motionOpt.dur + 's'"  :begin="beginAt(motionOpt.begin)"
      )
      slot(name="animations")
    g(ref="decendant"  :transform="relativeTransform")
      slot()
</template>
<script lang="coffee">
  MOTION_TYPES= SERIAL: "serial", PARALLEL: "parallel"
  Components=
    Path:
      props:
      render: (createElement, context)->
        createElement(...)
    AnimateMotion:
      props:
      render: (createElement, context)->
        createElement(...)
  export default
    components:
      Draw:
        functional: true
        props: ["d"]
        render: (createElement, context)->

          createElement(...)
    data: ->
      motionOpt:  do =>
        return false if not @motion
        motion= _.extend @motion, begin: if @motion.mode? then null else @motion.begin
        _.defaults motion,
          mode: MOTION_TYPES.SERIAL
          fill: "freeze", rotate: "auto", dur: 1
    props:
      tag: default: null
      c: default: null
      animate: default: on
      dur: default: 1
      begin: default: null # Number, String
      motion: default: null # Hash
      dFill: default: "freeze" #fill attribute for draw animation
    computed:
      motionTransform: ->
      relativeTransform: ->"translate(#{@origin.x + @delta.x} #{@origin.y + @delta.y})"
    filters:
      id: (arg, suffix)->if arg? then "#{arg}#{suffix}" else ""
    methods:
      beginAt: (begin)->
        begin= if /^[\.0-9]+$/.test begin then +begin else begin
        if _.isNumber(begin) then "#{begin}s" else if _.isString(begin) then "#{begin}" else NOOP
      onStartDraw: ->
        if @motionOpt.mode is  MOTION_TYPES.PARALLEL
          @$refs.motionAnimation.beginElement()
      onEndDraw: ->
        _.each @$refs.decendant.children, (el)->
          if (el= el.firstChild.children[0]).getAttribute("begin") is NOOP then el.beginElement()
        if @motionOpt.mode is  MOTION_TYPES.SERIAL
          @$refs.motionAnimation.beginElement()
</script>
