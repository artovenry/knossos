import Vue from "vue"
import Main from "./four/Main.vue"
document.addEventListener "DOMContentLoaded", ->new Vue el: "#v-app", render: (h)->h(Main)
