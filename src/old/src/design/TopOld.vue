<template lang="pug">
  #v-dev
    #header
      #logo-wrapper
        h1#logo
          a(href="#" title="spannko - スパン子 -")
            span.text-hide spannko - スパン子 -
            img(src="/wp-content/themes/theme/static/logo-spannko.svg" alt="spannko - スパン子 -")
      //-
        #lang-selector
          span: img(src="/wp-content/themes/theme/static/ja.svg" alt="japanese site")
          span /
          span: img(src="/wp-content/themes/theme/static/en.svg" alt="english site")
        //-
          span: img(src="/wp-content/themes/theme/static/pianokey.svg")
        //-
          span: img(src="/wp-content/themes/theme/static/key.png")

    nav#nav
      a(href="#" title="news") news
      a(href="#" title="schedule") schedule
      a(href="#" title="about") about
      a(href="#" title="spannkosmo") spannkosmo
      a(href="#" title="works") works
      a(href="#" title="blog") blog
      a(href="#" title="links") links
      a(href="#" title="contact") contact
      a(href="#" title="gallery") gallery
</template>
<style lang="scss">
  @import "~bootstrap/scss/mixins/text-hide";
  @import "~bootstrap/scss/mixins/image";
  @import "variables";
  #header{
    width: 100vw;height: calc(100vh);
    background: map-get($colors, primary);
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  #logo-wrapper{
    margin-top: calc(30vh);
    margin-bottom: 1.5rem;
    width: 80vw;height: 30vh;
    background: url(/wp-content/themes/theme/static/pioneer_pulser.svg) left top /cover;
  }
  #logo{
    padding-top: 3rem;
    padding-left: 10rem;
    a img{
      width: 22vw;
    }
  }

  #lang-selector{
    color: map-get($colors, ash);
    span:first-of-type{margin-right: .5rem;}
    span{
      display: inline-block;
      width: 1rem;
      img{@include img-fluid;}
    }
  }
  #nav{
    display: flex;
    flex-direction: column;
  }
</style>
