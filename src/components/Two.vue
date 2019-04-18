<template lang="pug">
  #wrapper
    svg#knossos(viewbox="0 0 640 640")
      g(stroke="#AAAAAA")
        //- line(x1=500 y1=0  x2=500 y2=1000 stroke="yellow")
        //- line(x1=0 y1=500  x2=1000 y2=500 stroke="yellow")
      g(stroke="blue" fill="none" stroke-width=8)
        path(:d="draw1")
      g(stroke="green" fill="none" stroke-width=8)
        path(:d="draw2")
      //- rect(stroke="none" fill="red"  :x="500-50*2"  :y="500-50*2"  :width="50*4"  :height="50*4" opacity="0.38")
</template>

<style lang="scss">
  #wrapper{background: #000;position: absolute;width:100%;height:100%;}
  #knossos{width: 100%;height:100%;}
</style>

<script lang="coffee">
  R = 1
  L = 0
  export default
    data: ->
      u: 32
    methods:
      m: (dx, dy)->
        "m #{dx*@u} #{dy*(-1)*@u}"
      l: (dx, dy)->
        "l #{dx*@u} #{dy*(-1)*@u}"
      a: (diam, dx, dy, cw=1)->
        "a #{parseFloat(diam*@u/2)} #{parseFloat(diam*@u/2)} 0 0 #{cw} #{dx*@u} #{dy*(-1)*@u}"
    computed:
      draw1: ->
        _.flatten([
          "M 320 320"
          @m -2, 2
          @a  3,  3,  0, R
          @a  2,  2,  0, L
          @a  7, -7,  0, L
          @a  4,  2, -2, L
          @l  4,  0
          @a  4,  2,  2, L
          @a  9, -9,  0, L
          @a  6,  3, -3, L
          @a  2,  0, -2, R
          @a 10, -5,  5, R
          @a 13, 13,  0, R
          @a  8, -4, -4, R

          #

        ]).join(" ")

      draw2: ->
        _.flatten([
          "M 320 320"
          @m  2,  2
          @a  5, -5,  0, L
          @a  2,  2,  0, L
          @a  1,  1,  0, R
          @l  0, -4
          @a  4, -2, -2, R
          @a 12, -6,  6, R
          @a 15, 15,  0, R
          @a 10, -5, -5, R
          @a  2, -0,  2, R
          @a  6,  3,  3, L
          @a 11,-11,  0, L
          @a  8,  4, -4, L


        ]).join(" ")

</script>
