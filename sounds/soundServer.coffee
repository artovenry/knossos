path= require "path"
express= require "express"
_= require "underscore"
host= process.env.npm_config_host ? "localhost"
port = "10000"

app= express()


app.use (req, res, next)->
    res.header("Access-Control-Allow-Origin", "*")
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")
    next()
# app.use (req, res, next)->
#   _.delay (-> next()), _.random(3, 5) * 700
  # next()
app.use "/", express.static(path.resolve(__dirname))


app.listen 10000, host, ->
  console.log "soundServer listening on http://#{host}:10000, Ctrl+C to stop"
