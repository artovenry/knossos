<template lang="pug">
  #knossos2
    #top
      svg#animation(:viewBox="globalViewBox")
        rect#rect(fill="none" stroke="white" x=0 y=0 :width="globalSize.width" :height="globalSize.height")
        Teatoron
        Labyrinth
        Thumele
        Ariadne
    hr
    #actions
      a#pause(href="#" @click.prevent="$store.dispatch('pause')") pause
      a#resume(href="#" @click.prevent="$store.dispatch('resume')") resume
      #elapsed {{$store.state.audio.elapsed|floor}}
</template>
<style lang="scss">
  $DAWN: lighten(#030311, 3%); $NIGHT: #000;
  #top{
    position:absolute;width:100%;height:100%;
    display:flex;justify-content: center;align-items: center;
    background: $NIGHT;
    z-index:1;
  }
  #actions{
    a{color: #888;}z-index:2;
    position:absolute;width:20%;height:10%;bottom :0;
    display:flex;justify-content:space-between;align-items: center;
    font-size: 7px;
  }

  #animation{height: 90%;}
  #orquestra path{fill:#c6c6c8;/* fill: lighten(#7A280E, 45%);*/}
</style>
<script lang="coffee">
  import store from "./Three/store"
  import Teatoron from "./Three/Teatoron.vue"
  import Labyrinth from "./Three/Labyrinth.vue"
  import Thumele from "./Three/Thumele.vue"
  import Ariadne from "./Three/Ariadne.vue"
  import {GLOBAL_SIZE, KNOSSOS_ORIGIN} from "./Three/constants"
  export default
    components: {Teatoron, Labyrinth, Thumele, Ariadne}
    store: store
    mounted: ->@$store.dispatch "initialize"
    filters:
      floor: (time)-> Math.floor(time * 100)  * 1/100
    data: ->
      globalSize: GLOBAL_SIZE
      globalViewBox: "0 0 #{GLOBAL_SIZE.width} #{GLOBAL_SIZE.height}"
      origin: KNOSSOS_ORIGIN
</script>
