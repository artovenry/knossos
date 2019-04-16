import delta from "./Draw/curve"
TYPES= LINE: "l", CURVE: "c"
NOOP= "noop"

measure= (arg, origin=on)->
  arg= arg.split " "
  return new class
    # For injective operation for measure objects
    add: (measure)->
      @[key]= item + measure[key] for key, item of @
    constructor: ->
      if absolute= arg[0] isnt TYPES.LINE and arg[0] isnt TYPES.CURVE
        [@x, @y, type]= arg[0..2]
      else
        [@x, @y, type]= [0, 0, arg[0]]
      [@x, @y]= [+@x, +@y]
      origin= if origin then "m #{@x} #{@y}" else ""
      switch type
        when TYPES.LINE
          [@dx, @dy]= arg[(if absolute then 3 else 1)..]
          [@dx, @dy]= [+@dx, +@dy]
          @cmd= "#{origin} l #{@dx} #{@dy}"
          @length= Math.sqrt(@dx**2 + @dy**2)
        when TYPES.CURVE
          [r, cType, theta]= arg[(if absolute then 3 else 1)..]
          [r, cType, theta]= [+r, +cType, +theta]
          [@dx, @dy]= delta(r, theta, cType, array=on)
          longArc= if theta <=180 then 0 else 1
          rotation= if cType % 2 is 0 then 0 else 1
          @cmd= "#{origin} a #{r} #{r} 0 #{longArc} #{rotation} #{@dx} #{@dy}"
          @length= 2*r*Math.PI  * theta / 360

parse= (vnodes)->
  vnodes.forEach (vnode)->
    if (childIsDraw= vnode.children[0].elm.tagName.toLowerCase() is "path")
      do(el = elAnimate= vnode.children[0].children[0].elm)->
        attr= (name)->el.getAttribute name
        if attr("attributeName") is "visibility"
          if attr("end") is NOOP then el.endElement()
        if attr("attributeName") is "stroke-dashoffset"
          if attr("begin") is NOOP then el.beginElement()
    # else  parse vnode.children[0].children


Draw=
  functional: on, props:
    tag:        default: null
    c:          default: ""
    animate:    default: yes
    dt:         default: 1
    t:          default: null
    dFill:      default: 'freeze'
    keySplines: default: null
    end:        default: null
    max:        default: null
  render: ($, context)->
    if multiple= context.props.c.match /\|/
      cs= context.props.c.split("|")
      initial= measure(cs[0])
      {x,y}= initial
      {dx, dy, cmd, length}= _.inject cs[1..], (memo, item)->
        memo.add measure(item, origin=no)
        memo
      , initial
    else
      {x, y, dx, dy, cmd, length}=  measure context.props.c

    $ "g", _.compact _.values
      Main: $ "path",
        attrs: _.extend context.data.attrs,
          d: cmd
          "stroke-dasharray": length
          "stroke-dashoffset": if  context.props.animate then length  else 0
      , _.compact _.flatten _.values
        ToggleAnimation: if  not context.props.animate then $ "animate",
          attrs: do ->
            {t, tag} = context.props
            id: if tag? then  "#{tag}_toggle"
            attributeName:"visibility"
            from: "hidden", to: "visible"
            begin: 0,  dur: "99999s",  fill: "remove"
            end: do ->
              t= if /^[\.0-9]+$/.test t then +t else t
              if _.isNumber(t) then "#{t}s" else if _.isString(t) then "#{t}" else NOOP
          on: endEvent: ->if (items= context.slots().default)? then parse items
        DrawAnimation: if  context.props.animate then $ "animate",
          attrs: do ->
            {tag, dt, t, dFill, keySplines, end, max} = context.props
            id: if tag? then  "#{tag}_draw"
            attributeName:"stroke-dashoffset"
            from: length, to: 0, fill: dFill, dur: dt + "s"
            end: end
            max: max
            calcMode: if keySplines? then 'spline'
            keyTimes: if keySplines? then '0;1'
            keySplines: if keySplines? then do ->
              keySplines.split(",").join(' ')
            begin: do ->
              t= if /^[\.0-9]+$/.test t then +t else t
              if _.isNumber(t) then "#{t}s" else if _.isString(t) then "#{t}" else NOOP
          on: endEvent: ->if (items= context.slots().default)? then parse items
        Animations: context.slots().animations
      Decendants: if context.slots().default? then $ "g",
        attrs: transform: "translate(#{x + dx} #{y + dy})"
      , context.slots().default

export Motion=
  functional: on, props:
    tag: {default: ""}
    c: {default: ""}
    dt: {default: 1}
    t: {default: null}
    fill: {default: 'freeze'}
    rotate: {default: 'auto'}
    motionTransform: {default: ''}
    keySplines: default: null
  render: ($, context)->
    {c ,dt, t, fill, rotate, tag, keySplines}= context.props
    {cmd}= measure c
    $ "g",  _.values
      Target: $ "g", {attrs: transform: context.props.motionTransform}, context.slots().default
      Motion: $ "animateMotion",
        attrs: do ->
          if tag? then context.data.attrs.id= "#{tag}_motion"
          _.extend context.data.attrs,
          fill: fill, dur: dt + "s", begin: t, path: cmd, rotate: rotate
          calcMode: if keySplines? then 'spline'
          keyTimes: if keySplines? then '0;1'
          keySplines: if keySplines? then do ->
            keySplines.split(",").join(' ')
        on: beginEvent: ->parse context.slots().default


export default Draw
