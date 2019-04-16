_ = require "underscore"
env = require "./env.coffee"
webpack= require "webpack"
VueLoaderPlugin      = require "vue-loader/lib/plugin"
HtmlWebpackPlugin    = require "html-webpack-plugin"
OptimizeCssAssetsPlugin= require "optimize-css-assets-webpack-plugin"
MiniCssExtractPlugin = require "mini-css-extract-plugin"

module.exports= _.compact _.flatten _.values
  Provide: new webpack.ProvidePlugin
    _     : "underscore"
    TWEEN : "@tweenjs/tween.js"
    Color : "color-js"
  Define:
    new webpack.DefinePlugin
      NODE_HOST:  JSON.stringify(env.host)
      NODE_PORT:  JSON.stringify(env.port)
  VUE: new VueLoaderPlugin
  HWP: [
    new HtmlWebpackPlugin template: "src/assets.php.ejs", inject: off, filename: "assets.php", env: env
    if env.development then [
      new HtmlWebpackPlugin template: "src/design.pug", inject: off, filename: "index.html", env: env
      new HtmlWebpackPlugin template: "src/design2.pug", inject: off, filename: "./2/index.html", env: env
    ]
  ]
  OptimizeCss: if env.optimized then new OptimizeCssAssetsPlugin()
  EXTRACT_CSS:  do ->
    if env.extract_css
      new MiniCssExtractPlugin filename: if env.production then "[hash:6]-[name].css" else "[name].css"
