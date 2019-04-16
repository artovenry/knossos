import Vue from "vue"
import Main from "./general/Main.vue"
document.addEventListener "DOMContentLoaded", ->new Vue el: "#v-app", render: (h)->h(Main)
