<template lang="pug">
  g
    path(:d="d"  :id="'path_'+tag"  :stroke-dasharray="length"  :stroke-dashoffset="animate ? length : 0"  :visibility="visibility ? 'visible' : 'hidden'")
      animate(v-if="animate"  :id="'draw_'+tag"  attributeName="stroke-dashoffset"  :from="length" to="0"  :dur="dur+'s'"  :begin="startAt(begin)"  :fill="afill"  @endEvent="startDescendentAnimations")
      animate(v-else dummy)
      animateMotion(v-if="motion"  v-bind="motion"  :id="'motion_'+tag"    :dur="motion.dur+'s'"  :begin="startAt(motion.begin)" fill="freeze"  rotate="auto")
        mpath(:xlink:href="motion.path")
      animateMotion(v-else dummy)
      slot(name="animation1")
      slot(name="animation2")
      slot(name="animation3")
    g(:transform="translate")
      slot
</template>
<script lang="coffee">
  TYPES= LINE: "l", CURVE: "c"
  NOOP= "noop"
  export default
    props:
      c: default: "" # Command
      animate: default: on
      dur: default: 1
      begin: default: null
      afill: default: "freeze"
      tag: default: ""
      motion: default: null
      visibility: default: true
    methods:
      startAt: (begin)->
        begin= if /^[\.0-9]+$/.test begin then +begin else begin
        if _.isNumber(begin) then "#{begin}s" else if _.isString(begin) then "#{begin}" else NOOP
      startDescendentAnimations: ->
        _.each @$el.lastChild.children, (el)->
          if (el= el.firstChild.children[0]).getAttribute("begin") is NOOP then el.beginElement()
        if (el= @$el.firstChild.children[1]).tagName.toLowerCase() is "animatemotion" and el.getAttribute("begin") is NOOP then  el.beginElement()

    data: ->
      words= _.compact(@c.split " ")
      absolute= if not RegExp("^(#{TYPES.LINE}|#{TYPES.CURVE}).+").test @c then true else false
      drawType= words[if absolute then 2 else 0]
      if drawType is TYPES.CURVE
        [r, cType, theta]= words[(if absolute then 3 else 1)..]
        [r, cType, theta]= [+r, +cType, +theta]
        {words, absolute, drawType, cType, r, theta}
      else
        {words, absolute, drawType}



    computed:
      length: ->
        switch @drawType
          when TYPES.LINE then Math.sqrt(Math.pow(@delta.x, 2)+Math.pow(@delta.y,2))
          when TYPES.CURVE then 2*@r*Math.PI  * @theta / 360
      d: ->
        origin= if @absolute then x: @words[0], y: @words[1] else x: 0, y: 0
        command= switch @drawType
          when TYPES.LINE
            "l #{@delta.x} #{@delta.y}"
          when TYPES.CURVE
            longArc= if @theta <=180 then 0 else 1
            rotation= if @cType % 2 is 0 then 0 else 1
            "a #{@r} #{@r} 0 #{longArc} #{rotation} #{@delta.x} #{@delta.y}"
        "m #{origin.x} #{origin.y} #{command}"
      delta: ->
        switch @drawType
          when TYPES.LINE
            data= @words[(if @absolute then 3 else 1)..]
            return x: +data[0], y: +data[1]
          when TYPES.CURVE
            rad= 2*Math.PI  * @theta /360
            longArc= if @theta <=180 then 0 else 1
            rotation= if @cType % 2 is 0 then 0 else 1
            d= x: @r*Math.sin(rad), y: @r - @r*Math.cos(rad)
            Identity= (d)-> d
            ReflectX= (d)-> x: d.x, y: -d.y
            ReflectY= (d)-> x: -d.x, y: d.y
            Rotate90= (d)-> x: -d.y, y: d.x
            Transform= switch @cType
              when 1 then Identity
              when 2 then _.compose Rotate90, ReflectX
              when 3 then Rotate90
              when 4 then ReflectY
              when 5 then _.compose Rotate90, ReflectY, Rotate90, ReflectX
              when 6 then _.compose Rotate90, ReflectY
              when 7 then _.compose ReflectX, Rotate90, ReflectX
              when 8 then ReflectX
            return  x: Transform(d).x,  y:Transform(d).y
      translate: ->
        if @absolute
          [x, y]= @words[0..1]
          "translate(#{+x + @delta.x} #{+y + @delta.y})"
        else
          "translate(#{@delta.x} #{@delta.y})"
</script>
