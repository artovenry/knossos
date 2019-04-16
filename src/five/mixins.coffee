draw= (d)->
  start= if @relative then "m #{@origin[0] * @unit} #{@origin[1] * @unit}" else ""
  _.inject d, (memo, data)=>
    str= if _.isString data then data  else
      data= _.clone(data)
      if _.isNumber(data[1]) then data[1] = [data[1]]
      scaled= _.map data[1], (item)=>item * @unit
      switch data[0]
        when Move then "m #{scaled[0]} #{scaled[1]}"
        when d then "m 0 #{scaled[0]}"
        when u then "m 0 #{scaled[0] * -1}"
        when r then "m #{scaled[0]} 0"
        when l then "m #{scaled[0] * -1} 0"
        when H then "h #{scaled[0]}"
        when V then "v #{scaled[0]}"
        when Line then "l #{scaled[0]} #{scaled[1]}"
        when A    then "a #{scaled[0]} #{scaled[0]} 0 0 #{data[2]} #{scaled[1]} #{scaled[2]}"
    _.compact([memo, str]).join " "
  , start


export default
  methods: {draw}
  props:
    unit: default: 16
    origin: default: ->[50, 25]
    animate: default: on
