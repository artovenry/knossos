import Vue from "vue"
import Vuex from "vuex"
Vue.use Vuex
Axios= require "axios"


class AudioController
  constructor: ->
    @context= null
    @src= null
  initialize: (data)->
    new Promise (resolve)=>
      @context = new AudioContext()
      @src= @context.createBufferSource()
      @context.decodeAudioData data, (buf)=>
        @src.buffer=buf
        resolve(@)
        @play()
  play: ->
    @src.connect(@context.destination)
    @src.start()
  pause: ->
    @context.suspend()
  resume: ->
    @context.resume()
  playAt: (start, duration)->
    @src.connect(@context.destination)
    @src.start()


audioController= new AudioController

export default new Vuex.Store
  state:
    audio:
      active: no
      elapsed: 0
  getters:
    activeAriadne: ()->off
  mutations:
    activateAudio: (state)->state.audio.active= yes
    updateElapsed: (state, timestamp)->state.audio.elapsed= timestamp
  actions:
    pause: ->audioController.pause()
    resume: ->audioController.resume()
    initialize: (context)->
      Axios.get "http://#{NODE_HOST}:10000/hitononekko.mp3",
        responseType: "arraybuffer"
      .then (rs)->
          audioController.initialize(rs.data).then (controller)->
            context.commit("activateAudio")
            window.setInterval ->
              context.commit("updateElapsed", controller.context.getOutputTimestamp().contextTime)
            , 100
