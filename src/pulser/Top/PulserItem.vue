<template lang="pug">
  g
    slot
</template>
<script lang="coffee">
  ORIGIN= x: 174, y: 218
  export default
    props: ["transform"]
    data: ->
      found= @transform.match /translate\((.+), (.+)\)/
      delta= x: parseFloat(found[1]), y: parseFloat(found[2])
      quadrant: do->
        if delta.x >= ORIGIN.x
          if delta.y < ORIGIN.y then 0 else 3
        else
          if delta.y < ORIGIN.y then 1 else 2
      x: delta.x
      y: delta.y
      scale: 0
    computed:
      transformStyle: ->
        transform= "translate(#{@x}px, #{@y}px) scale(#{@scale})"
        origin= do =>
          switch @quadrant
            when 0 then "0px #{ORIGIN.y - @y}px"
            when 1 then "#{ORIGIN.x - @x}px #{ORIGIN.y - @y}px"
            when 2 then "#{ORIGIN.x - @x}px #{@y - ORIGIN.y}px"
            when 3 then "#{@x - ORIGIN.x}px #{@y - ORIGIN.y}px"
        # stroke= do =>
        #   switch @quadrant
        #     when 0 then "green"
        #     when 1 then "yellow"
        #     when 2 then "blue"
        #     when 3 then "magenta"
        "transform: #{transform}; transform-origin: #{origin};"

    mounted: ->
      @$watch "scale", =>
        @$el.setAttribute "style", @transformStyle
      , immediate: on
</script>
