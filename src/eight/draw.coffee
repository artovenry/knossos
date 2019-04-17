to_f= _.partial parseInt, _, 10
export default
    props:
      d: {default: null}
      t: {default: 0}
      dt: {default: 1}
      a: {default: ->{}}
    data: ->
      length= 0
      cmds= _.inject @d.split(/\s*\|\s*/),  (memo, item)->
        switch item[0..0]
          when "l"
            [dx, dy]=item.split(/\s+/)[1..].map to_f
            length= length + Math.sqrt(dx**2+dy**2)
            return "#{memo} #{item}"
          when "a"
            [r, rot, theta]=item.split(/\s+/)[1..].map to_f
            length= length + Math.PI*r*theta/180
            [dx, dy]=  do (x=r*Math.sin(Math.PI*theta/180), y=r*(1-Math.cos(Math.PI*theta/180)))-> [[x,y], [y,x], [-y,x], [-x,y], [-x,-y], [-y,-x], [y,-x], [x,-y]][rot-1]
            return "#{memo} a #{r} #{r} 0 #{if theta <=180 then 0 else 1} #{if rot % 2 is 0 then 0 else 1} #{dx} #{dy}"
      {length, cmds}
    render: ($)->
      pathData= attrs: "d": @cmds, "stroke-dasharray": (if @a then @length), "stroke-dashoffset": (if @a then @length)
      $animate= if @a then $ "animate", attrs: do =>
        attrs= _.extend @a,
          attributeName: "stroke-dashoffset"
          id: if (id=@$attrs.id) then "#{id}_draw"
          from: @length, to: 0
          begin: if isNaN (ft= to_f(@t)) then @t else "#{ft}s"
          dur: if @dt? then "#{@dt}s" else "1s"
        _.defaults attrs, fill: "freeze"
      $ "path", pathData , _.compact [
        $animate
        @$slots.default
        # @$scopedSlots.default? length: @length
      ]
