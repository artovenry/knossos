<template lang="pug">
  #labyrinth
    svg(viewBox="0 0 1200 800" width="1200px" style="border: 1px solid #AAA;margin: 5%")
      path.upperleft(
        fill="none"
        stroke="black"
        :d="drawUpperleft| draw"
      )
        animate(
          attributeType="XML" attributeName="d"
          :from="fig(0)|draw"  :to="fig(1)|draw" dur="30000ms" fill="freeze"
        )
</template>
<script lang="coffee">
  [Move, A, Line]= ["m", "a", "l"]
  [L, R]= [0 ,1]
  ORIGIN= x:600, y:500
  data2cmd= (data, scale= 1)->
    scaler= _.map data[1], (item)->item * scale
    switch data[0]
      when Move then "m #{scaler[0]} #{scaler[1]}"
      when Line then "l #{scaler[0]} #{scaler[1]}"
      when A    then "a #{scaler[0]} #{scaler[0]} 0 0 #{data[2]} #{scaler[1]} #{scaler[2]}"
  export default
    data: ->
      upperLeft: [
        [Move, [-4, -4]]
        [A, [ 3,   6,   0], R]
        [A, [ 2,   4,   0], L]
        [A, [ 7, -14,   0], L]
        [A, [ 4,   4,   4], L]
        [Line, [ 8, 0]]
        [A, [ 4,   4,  -4], L]
        [A, [ 9, -18,   0], L]
        [A, [ 6,   6,   6], L]
        [A, [ 2,   0,   4], R]
        [A, [10, -10, -10], R]
        [A, [13,  26,   0], R]
        [A, [ 8,  -8,   8], R]
      ]
    filters:
      draw: (cmds)->
        cmds= _.inject cmds, (memo, item)=>
          _.compact([memo, data2cmd(item, 16)]).join " "
        , ""
        "M #{ORIGIN.x} #{ORIGIN.y} #{cmds}"
    methods:
      fig: (index)->
        switch index
          when 0 then @upperLeft
          when 1 then _.map @upperLeft, (item)->
            return item if item[0] isnt A
            if _.random(0,1)
              [A, [item[1][0], -item[1][1], -item[1][2]], +!item[2]]
            else item
    computed:
      drawUpperleft: -> @upperLeft
</script>
