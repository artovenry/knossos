import Vue from "vue"
import Main from "./five/Main.vue"
import store from "./five/store"
document.addEventListener "DOMContentLoaded", ->new Vue el: "#v-app", store: store, render: (h)->h(Main)
