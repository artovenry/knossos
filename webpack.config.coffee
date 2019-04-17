_= require "underscore"
path= require "path"
webpack= require "webpack"
htmlWebpackPlugin= require "html-webpack-plugin"
VueLoaderPlugin= require "vue-loader/lib/plugin"
MiniCssExtractPlugin = require "mini-css-extract-plugin"
Autoprefixer= require "autoprefixer"

module.exports=
  mode: "development"
  devtool: "inline-source-map"
  resolve:
    extensions:[".js", ".coffee" ,".json"]
  devServer:
    host: process.env.npm_config_host ? "localhost"
    port: process.env.npm_config_port ? "8080"
    contentBase: [
      path.join(__dirname, "")
      path.join(__dirname, "src")
    ]
  entry:
    # D3とSnap.svgのテストを兼ねて。
    ring: "./src/ring.coffee"

    # スパン子トップページ、パイオニア2号から借用
    pulser: "./src/pulser.coffee"
    pulser_style: "./src/pulser.scss?extract"

    # スパン子の一般ページの色的構想の超初期
    general: "./src/general.coffee"

    # 真ん中であかっぽい靄のかかった中心の星が脈動してて、背景が濃い紺色、中心に向かって迷宮の壁が描かれている
    one: "./src/one.coffee"

    # 背景黒、青と緑で描かれた迷宮（アニメ無し）
    two: "./src/two.coffee"

    # 音楽付き。左右から観客席の半円周が交互に伸びるアニメ
    three: "./src/three.coffee"

    # 音楽付き。ランダムによじれた曲線が動く、おもしろいやつ。赤い球が、迷宮の中心から外に飛び出してゆくアニメ
    four: "./src/four.coffee"

    # 白地のアニメ。下から動きながら、迷宮が成長するやつ、途中で終わる
    five: "./src/five.coffee"

    # fiveと同じ。コードを改良したっぽい
    six: "./src/six.coffee"

    # fiveの改良版、完全な迷宮のまでアニメ、上昇と拡大を伴う
    seven: "./src/seven.coffee"

    # テアトロンの中を赤い球が踊りながら、周回するやつ。迷宮のアニメーションはない
    eight: "./src/eight.coffee"


  module:
    rules: do ->
      babelLoader=
        loader: "babel-loader", options: presets: ["@babel/env"]
      _.values
        JS     : test: /\.js$/, use: [babelLoader], exclude: /node_modules/
        COFFEE : test: /\.coffee$/, use: [babelLoader, {loader: "coffee-loader"}]
        VUE    : test: /\.vue$/, loader: "vue-loader"
        PUG    : test: /\.pug$/, loader: "pug-plain-loader"
        SCSS   : do ->
          loaders= (extract= no)-> _.compact [
            if extract then {loader: MiniCssExtractPlugin.loader, options: sourceMap: on}
            if not extract then {loader: "style-loader", options: sourceMap: on}
            {loader: "css-loader", options: sourceMap: on, importLoaders: 2}
            {loader: "postcss-loader", options: plugins: [Autoprefixer], sourceMap: on}
            {loader: "sass-loader", options: sourceMap: on}
          ]
          test: /\.s?css$/
          oneOf: _.values
            EXTRACT: resourceQuery: /extract/, use: loaders(extract= yes)
            DEFAULT: use: loaders(extract= no)
  plugins: _.compact _.flatten _.values
    provide: new webpack.ProvidePlugin
      _ : "underscore"
      TWEEN : "@tweenjs/tween.js"
      Color : "color-js"
    vue: new VueLoaderPlugin
    extract: new MiniCssExtractPlugin filename: "[name].css"
    # html: [
    #   new htmlWebpackPlugin()
    # ]
