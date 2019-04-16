path                 = require "path"
_                    = require "underscore"
env                  = require "./sample/env.coffee"
HtmlWebpackPlugin    = require "html-webpack-plugin"
MiniCssExtractPlugin = require "mini-css-extract-plugin"
VueLoaderPlugin      = require "vue-loader/lib/plugin"
config= require "./webpack.config.coffee"
rules                = require "./webpack/rules.coffee"

config.entry           = script: ["main.coffee"]
config.output          =
  filename      : "[name].js"
  chunkFilename : "[id].chunk.js"
  path          : path.resolve("sample/__bundled__")
  publicPath    : env.publicPath
config.mode            = "production"
config.resolve.modules = [path.resolve("sample"), "node_modules"]
config.plugins         =[
  new VueLoaderPlugin
  new HtmlWebpackPlugin template: "sample/index.pug", inject: off, filename: "index.html", env: env
  new MiniCssExtractPlugin filename: "[name].css"
]
config.module=  rules: rules(env)

module.exports= config
