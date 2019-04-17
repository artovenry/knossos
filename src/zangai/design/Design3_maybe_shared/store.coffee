import Vue from "vue"
import Vuex from "vuex"
import completed from "./data/completed"
import yeah from "./data/yeah"
import {first, second, move, motion,sonomae} from "./data/working"

data= {yeah,completed, first, second, move, motion, sonomae}
tags={}
_.each data, (item)->
  _.each item.frames, (frame)->
    frame.animationId= "animate#{window.crypto.getRandomValues(new Uint32Array(1))[0]}"
    if frame.tag? then tags[frame.tag]= frame.animationId

Vue.use Vuex
export default new Vuex.Store
  state: _.clone data
  modules:
    tags: state: _.clone tags
