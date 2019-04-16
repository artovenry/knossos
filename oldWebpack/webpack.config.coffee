path                 = require "path"
_                    = require "underscore"
env                  = require "./webpack/env.coffee"
rules                = require "./webpack/rules.coffee"
plugins              = require "./webpack/plugins.coffee"
UglifyJSPlugin       = require "uglifyjs-webpack-plugin"

module.exports=
  entry:
    style : ["main.scss"]
    design: ["design.coffee"]
    design2: ["design2.coffee"]
    # top   : ["top.coffee"]
  output:
    filename      : if env.production then "[hash:6]-[name].js" else "[name].js"
    chunkFilename : "[id].chunk.js"
    path          : do ->
      if env.production  then path.resolve("./theme/__bundled__")
      else path.resolve("__bundled__")
    publicPath    : env.publicPath

  resolve:
    modules: [path.resolve("src"), "node_modules"]
    extensions:[".js", ".coffee" ,".json"]

  mode: do ->
    if      env.optimized  then "production"
    else if env.production then "production"
    else                        "development"
  optimization:
    minimizer: [new UglifyJSPlugin()]
  devtool: "inline-source-map" if env.development
  devServer:
    host: env.host, port: env.port
    # contentBase: [path.resolve("."), path.resolve("./public")]
  module: rules: rules(env)
  plugins: plugins
