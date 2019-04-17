<template lang="pug">
  g
    path(:stroke-dasharray="stroke.dasharray"  :stroke-dashoffset="stroke.dashoffset"  :d="d")
      animate(v-if="animate"
        attributeName="stroke-dashoffset"
        :fill="animateFill"
        :dur="dur + 's'"
        :begin="startAt"
        :id="tag"
        :from="stroke.dashoffset"  :to="0"
        @endEvent="startDescendentAnimations"
      )
      slot(name="motion")
    g: slot
</template>
<script lang="coffee">
  NOOP= "noop"
  TYPES= LINE: "l", CURVE: "c"
  MAXDEG= 90
  # l: "x y dx dy"
  # c: "x y radius(0<= radius) type theta(0<=theta<=360)"
  export default
    props:
      c: default: ""
      type: default: TYPES.LINE
      animateFill: default: "freeze"
      dur: default: 1
      begin: default: null
      tag: default: null
      animate: default: on
    computed:
      cmds: ->@c.split(" ")
      # theta must be computed property (for extending this component)
      theta: -> if (theta= _.last @cmds) > MAXDEG then MAXDEG else theta
      stroke: ->
        switch @type
          when TYPES.LINE
            dasharray: length = Math.sqrt(Math.pow(@cmds[2], 2)+Math.pow(@cmds[3],2))
            dashoffset: if @animate then length else 0

          when TYPES.CURVE then do =>
            [r, theta]= [@cmds[2], @theta];
            length= Math.PI * r * theta / 180
            totalLength=
            dasharray: "#{length} #{totalLength}"
            dashoffset: if @animate then length else 0
      startAt: ->
        if _.isNumber(@begin) then "#{@begin}s" else if _.isString(@begin) then "#{@begin}.end" else NOOP
      d: ->
        [x, y]= @cmds[0..1]
        leading= "m #{x} #{y}"
        switch @type
          when TYPES.LINE
            "#{leading} l #{@cmds[2]} #{@cmds[3]}"
          when TYPES.CURVE then do =>
            B= 0.552284749831; R= 1 - B
            [r, type]= values[2..3];type= +type

            # L= [[1, R],[-R, 1],[-1, -R],[R, -1]]
            # deltaL= [[1, 1],[-1, 1],[-1, -1],[1, -1]]
            # R= [[-1, R],[R, 1],[1, -R],[-R, -1]]
            # deltaR= [[-1, 1],[1, 1],[1, -1],[-1, -1]]

            L= [[1, 1],[-1, 1],[-1, -1],[1, -1]]
            R= [[-1, 1],[1, 1],[1, -1],[-1, -1]]
            # start=[[B, 0], [0, B], [-B, 0], [0, -B], [-B, 0], [0 ,B], [B, 0], [0 -B]]
            start=[[1, 0], [0, 1], [-1, 0], [0, -1], [-1, 0], [0 ,1], [1, 0], [0, -1]]

            data= switch type
              when 1 then [L[0], L[1], L[2], L[3]]
              when 2 then [R[1], R[2], R[3], R[0]]
              when 3 then [L[1], L[2], L[3], L[0]]
              when 4 then [R[0], R[1], R[2], R[3]]
              when 5 then [L[2], L[3], L[0], L[1]]
              when 6 then [R[3], R[0], R[1], R[2]]
              when 7 then [L[3], L[0], L[1], L[2]]
              when 8 then [R[2], R[3], R[0], R[1]]

            commands= [
              "c #{start[type - 1][0]} #{start[type - 1][1]} #{ctrls[0][0]} #{ctrls[0][1]} #{} #{}"
              "s #{ctrls[0][0]} #{ctrls[0][1]} #{} #{}"
              "s #{ctrls[0][0]} #{ctrls[0][1]} #{} #{}"
              "s #{ctrls[0][0]} #{ctrls[0][1]} #{} #{}"
            ]




            return "#{leading} #{curve}"
    methods:
      startDescendentAnimations: ->
        if (el= @$el.firstChild.lastChild).tagName.toLowerCase() is "animatemotion" and el.getAttribute("begin") is NOOP then el.beginElement()
        _.each @$el.lastChild.children, (el)->
          if (_el= el.firstChild.firstChild).getAttribute("begin") is NOOP then _el.beginElement()



</script>
