<template lang="pug">
  - var pi= Math.PI
  - var sin= Math.sin
  - var cos= Math.cos
  - var pow= Math.pow
  #design52
    #top
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;height:100vh;")
        path(stroke="#AAA" d="m 0 400 h 1600")
        path(stroke="#AAA" d="m 800 0 v 800")
        g(:transform="globalTransform")
          g(transform="translate(0 -20)"  stroke="black" fill="none"  :stroke-width="2/scale")
            d#a1(d="m 0 0 | l 0 4"  dt=4)

            d(d="m 0 -16 | l  0 4 | a 1 3 180 | a 2 6 180"  dt=7 t="a1_draw.end")
            d#a2r(d="m 0 -16 | l  4 0 | a 4 1  90"          dt=7 t="a1_draw.end")
            d#a2l(d="m 0 -16 | l -4 0 | a 4 4  90 | a 2 2 180"   dt=7 t="a1_draw.end")
              animate(
                attributeName="stroke-dashoffset"
                additive="sum" calcMode="discrete"
                :from="0"  :to=`${2*Math.PI}`
                fill="freeze"  begin="a2l_draw.end"  dur="1ms"
              )

            d#a4(d="m0-0 | a 2 8 180"  :a="false"  visibility="hidden")
              animate(attributeName="visibility" values="hidden;visible" calcMode="discrete" dur="1ms"  begin="a2l_draw.end"  fill="freeze")
              animateMotion#a4_motion(path="m -8 -12 a 7 7 0 0 0 14 0"  dur="30s" begin="a2l_draw.end"  rotate="auto"  fill="freeze")
            d(dt=30 d="m -8 -12 | a 7 2 180"  t="a4_motion.begin")
            d(dt=30 d="m -6 -12 | a 5 2 180"  t="a4_motion.begin")
            d(dt=30 d="m -4 -12 | a 3 2 180"  t="a4_motion.begin")

            d#a5(d="m 8 -12 | a 9 3 180 | a 6 7 90"  t="a2l_draw.end"  dt=10)
            d#a6(d="m -4 -20 | a 8 4 90 | a 11 2 180 | a 6 6 90" t="a2l_draw.end"  dt=10)
            d#a5-1(d="m | a 2 8 180" t="a5_draw.end")
            d#a6-1(d="| a 2 5 180" t="a6_draw.end")


    #top
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;height:100vh;")
        g(:transform="globalTransform")
          - var r0= 40; var r1=30; var r2=22;
          g(title="観客席" opacity=1 fill="none"  :stroke-width="2 / scale"  stroke="#AAA")
            g(title="外野席")
              - var i=0
              while i < 15
                - i++
                circle(stroke="none" :r="4/scale" fill="black"
                  :cx=`${r0*cos(pi/12 * (i -2))}`
                  :cy=`${r0*sin(pi/12 * (i -2))}`
                )
                line(:x1="0"  :y1="0"
                  :x2=`${r0*cos(pi/12 * (i -2))}`
                  :y2=`${r0*sin(pi/12 * (i -2))}`
                )
              - var i=0
              while i <= 12
                //- - var ri= r1 + (r0-r1)*pow(1.6, 4*(i/30 -1))
                - var ri= r1 + (r0-r1)*i/12; i++
                path(
                  d=`
                    M ${ri*cos(-pi/12)} ${ri*sin(-pi/12)}
                    A ${ri} ${ri} 0 1 1 ${ri*cos(13*pi/12)} ${ri*sin(13*pi/12)}
                  `
                )
              g(title="マスク用" fill="white" stroke="none")
                path(
                  d=`
                    M ${r1*cos(-pi/12)} ${r1*sin(-pi/12)}
                    A ${r1} ${r1} 0 1 1 ${r1*cos(13*pi/12)} ${r1*sin(13*pi/12)}
                  `
                )
            g(title="内野席" stroke-width="2 / scale"  stroke-linejoin="round")
              - var i=0
              while i <= 12
                //- - var ri= r1 + (r0-r1)*pow(1.6, 4*(i/30 -1))
                - var ri= r2 + (r1-r2)*i/12; i++
                path(
                  d=`
                    M ${ri*cos(-pi/12)} ${ri*sin(-pi/12)}
                    A ${ri} ${ri} 0 1 1 ${ri*cos(13*pi/12)} ${ri*sin(13*pi/12)}
                  `
                )
              - var i= -1
              while i < 15
                - i++
                if (i % 2 == 1)
                  - continue
                circle(stroke="none" :r="4/scale" fill="black"
                  :cx=`${r1*cos(pi/12 * (i- 1))}`
                  :cy=`${r1*sin(pi/12 * (i- 1))}`
                )
                line(:x1="0"  :y1="0"
                  :x2=`${r1*cos(pi/12 * (i- 1))}`
                  :y2=`${r1*sin(pi/12 * (i- 1))}`
                )
              g(title="マスク用" fill="white" stroke="none")
                path(
                  d=`
                    M ${r2*cos(-pi/12)} ${r2*sin(-pi/12)}
                    A ${r2} ${r2} 0 1 1 ${r2*cos(13*pi/12)} ${r2*sin(13*pi/12)}
                  `
                )
          g(opacity=1 title="円形舞台"    :stroke-width="2 / scale")
            circle(fill="#FFF" cx=0 cy=0 r=0  stroke="none")
              animate(
                attributeName="fill"  fill="freeze"
                begin="ariadneMotion.end-2s"  dur="4s"
                calcMode="spline"
                keySplines=".05 .93 .24 .89"
                keyTimes="0;1"
                from="#FFF"  to="#990000"
              )
              animate(
                attributeName="r"  fill="freeze"
                begin="ariadneMotion.end-2s"  dur="3s"
                calcMode="spline"
                keySplines=".05 .93 .17 .96"
                keyTimes="0;1"
                from=0  to=r2
              )
            g(opacity=1 fill="none" stroke="#CCC"  stroke-linejoin="round")
              animateTransform(
                type="rotate" attributeName="transform"
                dur="1.6s" repeatCount="indefinite" accumulate="sum"
                values="0;30;30"
                begin="ariadneMotion1.end" end="click"
                calcMode="spline" keySplines=".91 .17 .72 1.31; 0 0 1 1" keyTimes="0;.5; 1"
              )
              defs
                rect#enkeiShikaku(x=`${r2*cos(5/4*pi)}` y=`${r2*sin(5/4*pi)}` width=`${r2/sin(1/4*pi)}` height=`${r2/sin(1/4*pi)}`)
              use(xlink:href="#enkeiShikaku")
              use(xlink:href="#enkeiShikaku" transform="rotate(30)")
              use(xlink:href="#enkeiShikaku" transform="rotate(60)")
          rect(title="オルケストラ" opacity=1 fill="#AAA"  stroke="none" x=-5  y=-12 width=12  height=12)
          circle(opacity=1  title="ミノタウロス"  cx="0"  cy="0"  :r="6/scale"  fill="red"  :stroke-width="2 / scale")
          g(title="アリアドネ" fill="none"   :stroke-width="1 / scale"  stroke="#000")
            path#motionPathAriadne(opacity=0
              d=`
                m 0 0
                a 5 5 0 0 0 -10 0
                a 10 10 0 0 0 20 0
                a 3 3 0 0 0 -6 0
                a 4 4 0 0 1 -8 0
                a 1 1 0 0 0 -2 0
                a 6 6 0 0 0 12 0
                a 1 1 0 0 1 2 0
                a 8 8 0 0 1 -16 0
                a 3 3 0 0 1 6 0
                a 2 2 0 0 0 4 0
                a 5 5 0 0 1 10 0
                a 12 12 0 0 1 -24 0
                a 7 7 0 0 1 7 -7
                a 5 5 0 0 0 0 -10
                a 17 17 0 0 0 -17 17
                a 22 22 0 0 0 44 0
                a 15 15 0 0 0 -15 -15
                a 3 3 0 0 0 0 6
                a 9 9 0 0 1 9 9
                a 16 16 0 0 1 -32 0
                a 11 11 0 0 1 11 -11
                a 1 1 0 0 0 0 -2
                a 13 13 0 0 0 -13 13
                a 18 18 0 0 0 36 0
                a 11 11 0 0 0 -11 -11
                a 1 1 0 0 1 0 -2
                a 13 13 0 0 1 13 13
                a 20 20 0 0 1 -40 0
                a 15 15 0 0 1 15 -15
                a 3 3 0 0 1 0 6
                a 9 9 0 0 0 -9 9
                a 14 14 0 0 0 28 0
                a 7 7 0 0 0 -7 -7
                a 5 5 0 0 1 0 -10
              `
            )
            path#motionPathAriadneCoda(opacity=0
              d="m 7 -17 a 17 17 0 0 1 15 17"
            )
            path#motionPathAriadneCircular(opacity=0
              d=`m ${r2} 0 a ${r2} ${r2} 0 0 1 ${-2*r2} 0 a ${r2} ${r2} 0 0 1 ${2*r2} 0`
            )

            circle(:r="8/scale"  fill="#c10a3d")
              animateMotion#ariadneMotion1(
                :dur="motionAriadne.dur + 's'" begin="0s" fill="freeze"
              ): mpath(xlink:href="#motionPathAriadne")
              animateMotion#ariadneMotion2(
                begin="ariadneMotion1.end" fill="freeze" calcMode="spline"
                :dur="coda.duration + 's'"
                keyPoints="0;1"
                keyTimes="0;1"
                :keySplines="coda.spline"
              ): mpath(xlink:href="#motionPathAriadneCoda")
              animateMotion#ariadneMotion3(
                :dur="motionAriadneCirclular.dur + 's'" begin="ariadneMotion2.end"  repeatCount="indefinite"
              ): mpath(xlink:href="#motionPathAriadneCircular")
          g(title="迷宮"  visibility="hidden" fill="none"   :stroke-width="1 / scale")
            path#red(stroke="red"
              d=`
                m 1 -12 l 0 12
                a 1 1 0 0 1 -2 0
                a 4 4 0 0 0 -8 0
                a 9 9 0 0 0 18 0
                a 2 2 0 0 0 -4 0
                a 5 5 0 0 1 -10 0
              `
            )
            path#blue(stroke="blue"
              d=`
                m 1 -6 l 6 0
                a 6 6 0 0 1 6 6
                a 13 13 0 0 1 -26 0
                a 8 8 0 0 1 8 -8
                a 4 4 0 0 0 0 -8
                a 16 16 0 0 0 -16 16
                a 21 21 0 0 0 42 0
                a 14 14 0 0 0 -14 -14
                a 2 2 0 0 0 0 4
                a 10 10 0 0 1 10 10
                a 17 17 0 0 1 -34 0
                a 12 12 0 0 1 12 -12
              `
            )
            path#green(stroke="green"
              d=`
                m 1 -6 l -6 0
                a 6 6 0 0 0 -6 6
                a 11 11 0 0 0 22 0
                a 4 4 0 0 0 -8 0
                a 3 3 0 0 1 -6 0
                a 2 2 0 0 0 -4 0
                a 7 7 0 0 0 14 0
              `
            )
            path#orange(stroke="orange"
              d=`
                m 7 -12
                a 12 12 0 0 1 12 12
                a 19 19 0 0 1 -38 0
                a 14 14 0 0 1 14 -14
                a 2 2 0 0 1 0 4
                a 10 10 0 0 0 -10 10
                a 15 15 0 0 0 30 0
                a 8 8 0 0 0 -8 -8
                a 4 4 0 0 1 0 -8
                a 16 16 0 0 1 16 16
                a 23 23 0 0 1 -46 0
                a 18 18 0 0 1 18 -18
                a 6 6 0 0 1 6 6
              `
            )
            g(stroke="none")
              circle(title="始点"  cx=1  cy=-12  :r="4/scale"  fill="red")
              circle(title="始点"  cx=-5  cy=-12  :r="4/scale"  fill="blue")
              circle(title="始点"  cx=1  cy=-6  :r="4/scale"  fill="green")
              circle(title="始点"  cx=7  cy=-12  :r="4/scale"  fill="orange")
</template>
<style lang="scss" scoped>
  #top  #top2{
    display: flex;justify-content:center;align-items: center;
    svg{ stroke: #777;fill: #777;width: 95vw;height:100vh;border: 0px solid #AAA;
    }
  }
  html, body, #design52, #top{background: #FFF;}
  #center{fill: #FFF;}
  #blue, #red, #green, #orange{stroke: #333}
</style>
<script lang="coffee">
  import Draw from "./draw"
  pi= Math.PI; sin= Math.sin; cos= Math.cos; sqrt= Math.sqrt
  export default
    data: ->
      scale: 12
      motionAriadne: length: 0, dur: 40
      motionAriadneCoda: length: 0
      motionAriadneCirclular: length: 0, dur: 20
    mounted: ->
      @motionAriadne.length= document.querySelector("#motionPathAriadne").getTotalLength()
      @motionAriadneCoda.length= document.querySelector("#motionPathAriadneCoda").getTotalLength()
      @motionAriadneCirclular.length= document.querySelector("#motionPathAriadneCircular").getTotalLength()
    components: {d: Draw}
    computed:
      coda: ->
        return {} if  @motionAriadneCoda.lenth is 0 or @motionAriadne.length is 0 or  @motionAriadneCirclular.length is 0
        l= @motionAriadneCoda.length
        v0= @motionAriadne.length / @motionAriadne.dur
        v1= @motionAriadneCirclular.length / @motionAriadneCirclular.dur
        a= (v1**2  - v0**2)/(2*l)
        duration= (2 * l) / (v0 + v1)

        p1x= 1/3 ; p1y= v0* duration / (3*l)
        p2x= 2/3
        p2y= 1 - ((a * duration**2 + v0*duration) / (3 * l))

        duration: duration
        spline: "#{p1x} #{p1y} #{p2x} #{p2y}"

      origin: ->#ミノタウロスの位置
        # x: 1600 / 2 / @scale
        # y: (800 / 2) / (@scale - 3)
        x: 1600 / 2 / @scale
        y: (800 / 2) / (@scale - 3)
      globalTransform: ->
        "scale(#{@scale}) translate(#{@origin.x} #{@origin.y}) scale(1, -1)"

# x: @teatoron.r * cos(pi/12 * (item - 1))
# y: @teatoron.r * sin(pi/12 * (item - 1))
</script>
