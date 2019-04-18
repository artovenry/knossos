<template lang="pug">
  #design
    //- #logo: a(href="#"): include ../theme/views/top/spannko.svg
    //- include design_nav.html
    //- #page-title
    //-   h1: a(href="#") news
    //- include design_posts.html
    #screen-1
    #screen-2
      #screen-21
        #screen-21-circle-1
          svg(viewBox="0 0 64 64" width="2.86rem")
            circle(cx=32 cy=32 r=32 fill="white" stroke="none")
            line(x1=13 y1=20 x2=50 y2=20 stroke-width="4" stroke="#333")
            line(x1=13 y1=30 x2=50 y2=30 stroke-width="4" stroke="#333")
            line(x1=13 y1=40 x2=50 y2=40 stroke-width="4" stroke="#333")

        #screen-21-circle-2
          svg(viewBox="0 0 64 64" width="2.86rem")
            circle(cx=32 cy=32 r=32 fill="white" stroke="none")
            line(x1=13 y1=20 x2=50 y2=20 stroke-width="2" stroke="#990000")
            line(x1=13 y1=30 x2=50 y2=30 stroke-width="2" stroke="#990000")
            line(x1=13 y1=40 x2=50 y2=40 stroke-width="2" stroke="#990000")

        #screen-21-logo
          //- include ../theme/views/top/spannko.svg
</template>
<style lang="scss">
  @import "../sass/variables";
  #screen-1{
    width: 100%;height:100%;overflow: hidden;
    position: absolute; top:0;left:0;
    background: map-get($colors, red);
  }
  #screen-2{
    width: 100%;height:100%;overflow: hidden;
    position: absolute; top:0;left:0;
    display: flex;align-items: center;
    &1{
      width: 45%; height: 96%;margin-left: 4%;
      background: adjust-color(map-get($colors, primary), $lightness: -80%, $alpha: -0.55);

      &-logo{
        width: 52%; margin: 1rem;
        svg path{fill: map-get($colors, white)}
      }
    }
  }
  // PARALLAX
    // #page-wrapper{
    //   width: 100vw;height:100vh;overflow: hidden;
    // }
</style>
