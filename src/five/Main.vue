<template lang="pug">
  #design3
    #top(style="display: flex;justify-content:center;align-items: center;margin-top:1rem;")
      svg(viewBox="0 0 1600 800" width="1600px" style="width: 95vw;border: 1px solid #AAA;")
        g(opacity=1)
          path(stroke="#EEE" d="m 0 400 h 1600")
          path(stroke="#EEE" d="m 800 0 v 800")
        //- Rotate(:animate="true"  origin="center"  :dur="2000"  :begin="0"  :theta="180"  :x="0"  :y="0")
        //- rect(x=300  y=400  width=100 height=100 fill="red")
        g(stroke="black" fill="none")
          //- DrawPath(v-bind="state.firstAnimation")
          //- DrawPath(stroke="green" fill="none" v-bind="state.birthOfO")
          DrawPath(
            v-bind="state.completed"
            stroke="#990000"
            opacity=.02
            transform=`rotate(0, ${800- 1 * 16}, ${400 - 4 * 16} )`
          )
          DrawPath(v-bind="state.yeah" stroke-width=3)
          //- DrawPath(:animate="false" v-bind="state.first")
          //- DrawPath(:animate="false" v-bind="state.sonomae")
          //- DrawPath(:animate="true" v-bind="state.second")
          //- DrawPath(v-bind="state.move")
          //-   MotionPath(v-bind="state.motion")
</template>
<style lang="scss">
</style>
<script lang="coffee">
  import Vue from "vue"
  import  {mapState} from "vuex"
  import DrawPath from "./DrawPath.vue"
  import MotionPath from "./MotionPath.vue"
  import Rotate from "./Rotate.vue"
  export default
    components:{DrawPath, MotionPath, Rotate}
    computed:
      state: ->@$store.state



</script>
