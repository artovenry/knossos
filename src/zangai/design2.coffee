import Vue from "vue"

import Design from "./design2/Design.vue"

document.addEventListener "DOMContentLoaded", ->
  new Vue
    el: "#v-app"
    render: (h)->h(Design)
