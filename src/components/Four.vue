<template lang="pug">
  #design2
    #top
      Labyrinth3
      //- Labyrinth2
      //- Labyrinth
    #actions
      a#pause(href="#" @click.prevent="$store.dispatch('pause')") pause
      a#resume(href="#" @click.prevent="$store.dispatch('resume')") resume
      #elapsed {{$store.state.audio.elapsed|floor}}
</template>
<style lang="scss">
  #actions{
    a{color: #888;}z-index:2;
    position:absolute;width:20%;height:10%;bottom :0;
    display:flex;justify-content:space-between;align-items: center;
    font-size: 7px;color: #AAA;
  }
</style>
<script lang="coffee">
  import soundStore from "./Four/soundStore"
  import Labyrinth from "./Four/Labyrinth.vue"
  import Labyrinth2 from "./Four/Labyrinth2.vue"
  import Labyrinth3 from "./Four/Labyrinth3.vue"
  import Explosion from "./Four/Explosion.vue"
  export default
    store: soundStore
    mounted: ->@$store.dispatch "initialize"
    components: {Labyrinth, Labyrinth2,Labyrinth3,Explosion}
    filters:
      floor: (time)-> Math.floor(time * 100)  * 1/100
</script>
