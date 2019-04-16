path= require "path"
_ = require "underscore"
Autoprefixer         = require "autoprefixer"
MiniCssExtractPlugin = require "mini-css-extract-plugin"


module.exports=  (env)->

  cssLoaders= (opts={vue: no, indented: no})->
    _.compact _.values
      STYLE: if not env.extract_css
        loader: if opts.vue then "vue-style-loader" else "style-loader"
      EXTRACT: if env.extract_css
        loader: MiniCssExtractPlugin.loader
      Css:
        loader: "css-loader"
        options:
          minimize: env.optimized
          sourceMap: env.development
      PostCss:
        loader: "postcss-loader"
        options:
          sourceMap: env.development
          plugins:[Autoprefixer]
      Sass:
        loader: "sass-loader"
        options:
          includePaths: [path.resolve("src/sass")]
          indentedSyntax: opts.indented
          sourceMap: env.development
  babelLoader=
    loader: "babel-loader", options: presets: ["@babel/env"], plugins: []


  _.values

    JS:
      test: /\.js$/, use: [babelLoader], exclude: /node_modules/

    COFFEE:
      test: /\.coffee$/, use: [babelLoader, {loader: "coffee-loader"}]

    Pug:
      test: /\.pug$/
      oneOf: [
        {resourceQuery: /^\?vue/, use: ["pug-plain-loader"]}
        {use: ["pug-loader"]}
      ]

    VUE:
      test: /\.vue$/, loader: "vue-loader"
    YAML:
      test: /\.y(a)?ml$/, loader: "json-loader!yaml-loader"
    Css:
      test: /\.css$/
      oneOf: [
        {resourceQuery: /^\?vue/, use: cssLoaders(vue: yes)}
        {use: cssLoaders()}
      ]
    Sass:
      test: /\.sass$/
      oneOf: [
        {resourceQuery: /^\?vue/, use: cssLoaders(vue: yes, indented: yes)}
        {use: cssLoaders(indented: yes)}
      ]
    Scss:
      test: /\.scss$/
      oneOf: [
        {resourceQuery: /^\?vue/, use: cssLoaders(vue: yes, indented: no)}
        {use: cssLoaders(indented: no)}
      ]
    Media:
      test: /\.(png|jpe?g|gif|svg)$/i , loader: "url-loader", options: limit: (if env.development then 10000) , name: "[name].[ext]"
