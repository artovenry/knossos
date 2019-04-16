path                 = require "path"
_                    = require "underscore"
env                  = require "./playground/env.coffee"
HtmlWebpackPlugin    = require "html-webpack-plugin"
MiniCssExtractPlugin = require "mini-css-extract-plugin"
VueLoaderPlugin      = require "vue-loader/lib/plugin"
config= require "./webpack.config.coffee"
rules                = require "./webpack/rules.coffee"

config.entry           = script: ["main.coffee"]
config.devServer.port = env.port
config.output          =
  filename      : "[name].js"
  chunkFilename : "[id].chunk.js"
  path          : path.resolve("playground/__bundled__")
  publicPath    : "http://#{env.host}:#{env.port}/"
config.mode            = "development"
config.resolve.modules = [path.resolve("playground/src"), "node_modules"]
config.plugins         =[
  new HtmlWebpackPlugin template: "playground/index.pug", inject: off, filename: "index.html", env: env
  new MiniCssExtractPlugin filename: "[name].css"
  new VueLoaderPlugin
]
config.module=  rules: rules(env)

module.exports= config
