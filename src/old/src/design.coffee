import Vue from "vue"

# 使わないときはインポートしないこと。Knossos.vueのscss要素がよまれちゃう
# import Design from "./design/Design.vue"
# import Design from "./design/TopKnossos.vue"
# import Design from "./design/Knossos.vue"
# import Design from "./design/Knossos2/Labyrinth.vue"
# import Design from "./design/Knossos2.vue"
# import Design from "./design/Design2.vue"
# require "./main.scss"

#----------ここまでは整理した

# import Design from "./design/Design3.vue"
# ---Design3は挫折したかも。。。
# import Design from "./design/Design4.vue"
# import Design from "./design/Design5.vue"
# import Design from "./design/Design51.vue"
# import Design from "./design/Design52.vue"
import Design from "./design/Design53.vue"
# import store from "./design/Design3/store"

document.addEventListener "DOMContentLoaded", ->
  new Vue
    el: "#v-app"
    render: (h)->h(Design)
