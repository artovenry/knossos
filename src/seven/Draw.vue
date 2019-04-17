<template lang="pug">
  g(:transform="motion ? motionTransform : ''")
    path(
      :d="d"
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
        @beginEvent="onBeginDraw"
      )
      PathAnimateMotion(v-if="motion"
        :c="motionOpt.path"
        ref="motionAnimation"
        :id="tag|id('_motion')"
        :fill="motionOpt.fill"  :rotate="motionOpt.rotate"
        :dur="motionOpt.dur + 's'"  :begin="beginAt(motionOpt.begin)"
        end="arc_motion.begin+1000ms"
      )
      slot(name="animations")
    g(ref="decendant"  :transform="relativeTransform")
      slot
</template>
<script lang="coffee">
  TYPES= LINE: "l", CURVE: "c"
  NOOP= "noop"
  MOTION_TYPES= SERIAL: "serial", PARALLEL: "parallel"
  draw=
    computed:
      d: ->
        path= switch @drawType
          when TYPES.LINE
            "l #{@cmd.dx} #{@cmd.dy}"
          when TYPES.CURVE
            longArc= if @cmd.theta <=180 then 0 else 1
            rotation= if @cmd.cType % 2 is 0 then 0 else 1
            "a #{@cmd.r} #{@cmd.r} 0 #{longArc} #{rotation} #{@delta.x} #{@delta.y}"
        "m #{@origin.x} #{@origin.y} #{path}"
      cmd: ->
        words= _.compact(@c.split " ")
        switch @drawType
          when TYPES.LINE
            _.object ["x", "y", "dx", "dy"] , do =>
              if @absolute
                [+words[0], +words[1], +words[3], +words[4]]
              else
                [0 ,0 ,+words[1], +words[2]]
          when TYPES.CURVE
            [r, cType, theta]= words[(if @absolute then 3 else 1)..]
            x: if @absolute then +words[0] else 0
            y: if @absolute then +words[1] else 0
            r: +r, cType: +cType, theta: +theta
      drawType: ->_.compact(@c.split " ")[if @absolute then 2 else 0]
      origin: -> if @absolute then x: @cmd.x, y: @cmd.y else x: 0, y: 0
      absolute: ->if not RegExp("^(#{TYPES.LINE}|#{TYPES.CURVE}).+").test @c then true else false
      delta: ->
        switch @drawType
          when TYPES.LINE
            return x: @cmd.dx, y: @cmd.dy
          when TYPES.CURVE
            rad= 2*Math.PI  * @cmd.theta /360
            longArc= if @cmd.theta <=180 then 0 else 1
            rotation= if @cmd.cType % 2 is 0 then 0 else 1
            d= x: @cmd.r*Math.sin(rad), y: @cmd.r - @cmd.r*Math.cos(rad)
            Identity= (d)-> d
            ReflectX= (d)-> x: d.x, y: -d.y
            ReflectY= (d)-> x: -d.x, y: d.y
            Rotate90= (d)-> x: -d.y, y: d.x
            Transform= switch @cmd.cType
              when 1 then Identity
              when 2 then _.compose Rotate90, ReflectX
              when 3 then Rotate90
              when 4 then ReflectY
              when 5 then _.compose Rotate90, ReflectY, Rotate90, ReflectX
              when 6 then _.compose Rotate90, ReflectY
              when 7 then _.compose ReflectX, Rotate90, ReflectX
              when 8 then ReflectX
            return  x: Transform(d).x,  y:Transform(d).y
      length: ->
        switch @drawType
          when TYPES.LINE then Math.sqrt(Math.pow(@cmd.dx, 2)+Math.pow(@cmd.dy,2))
          when TYPES.CURVE then 2*@cmd.r*Math.PI  * @cmd.theta / 360
  components=
    PathAnimateMotion:
      props: ["c"]
      mixins: [draw]
      render: (createElement)->
        createElement "animateMotion",
          attrs: path: @d

  export default
    mixins: [draw]
    components: components
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
      onBeginDraw: ->
        if @motionOpt.mode is  MOTION_TYPES.PARALLEL
          @$refs.motionAnimation.$el.beginElement()
      onEndDraw: ->
        _.each @$refs.decendant.children, (el)->
          if (el= el.firstChild.children[0]).getAttribute("begin") is NOOP then el.beginElement()
        if @motionOpt.mode is  MOTION_TYPES.SERIAL
          @$refs.motionAnimation.$el.beginElement()
</script>
