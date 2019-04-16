host= process.env.npm_config_host ? "localhost"
port = process.env.npm_config_port ? "8080"
env=
  host    : host
  port    : port
  optimized: no
  extract_css: no
  publicPath: "http://#{host}:#{port}/"

switch process.env.NODE_ENV
  when "development"
    env.development= yes
  when "production"
    env.production= yes
    env.optimized= yes
    env.extract_css= yes
    env.publicPath= "http://folkevise.net/spannko/wp-content/themes/theme/__bundled__/"
  when "optimized"
    env.development= yes
    env.optimized= yes
    env.extract_css= yes

module.exports= env
