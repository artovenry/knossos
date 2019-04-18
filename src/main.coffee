import Vue from "vue"
import Main from "./Main.vue"
document.addEventListener "DOMContentLoaded", ->
  new Vue　el: "#v-app", render: (h)->h Main
