<template lang="pug">
  #main
    router-view
    controller
</template>

<script lang="coffee">
  import Vue from "vue"
  import VueRouter from "vue-router"
  path= require "path"

  Vue.use VueRouter
  components= require.context("./components", off, /\.(vue)$/)
  router= new VueRouter routes: components.keys().map (filename)->
    path: "/#{path.basename(filename, ".vue")}"
    component: components(filename).default
  router.addRoutes [path: "/", redirect: "/index"]

  controller=
    render: (h)->
      <div id="controller">
        {for route in @$router.options.routes
          <router-link to={route.path}>{route.path}</router-link>
        }
      </div>
  export default router: router, components: controller: controller
</script>
<style lang="scss">
  #controller{
    background: #000;
    color: #CCC!important;
    font-weight: normal!important;
    a{color: lighten(#990000, 30%)!important;}
    font-size: .7rem!important;
    position: fixed;
    z-index:10000;
    bottom: 0;
    width: 100%;

    display: flex;
    flex-flow: row; justify-content: space-around;
  }
</style>
