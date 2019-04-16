require "./ring/d3sample.coffee"
import SvgAnimation from "./ring/SvgAnimation.vue"
import Vue from "vue"
document.addEventListener "DOMContentLoaded", ->new Vue el: "#v-app", render: (h)->h(SvgAnimation)
