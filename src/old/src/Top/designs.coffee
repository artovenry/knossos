# // $PUSER_COLOR: lighten(map-get($colors, ash), 10%);
# // $PUSER_COLOR: #caced2;
# // $PUSER_COLOR: #a6c4d2;
# $PUSER_COLOR: lighten(#a6c4d2, 10%);

# // g{
# //   stroke:$PUSER_COLOR;
# //   stroke-width: 0.4;
# //   // @include is-retina{stroke-width: 0.4;}
# // }

Tw= (target, group)->
  # return new TWEEN.Tween(target)
  if group? then new TWEEN.Tween( target, group) else new TWEEN.Tween(target)
E= TWEEN.Easing

DEFAULT_DATA=  ->
  screen : color: "#A71231", alpha: 0
  spannko: color: "#F1F1F1", width: 1, alpha: 0
  switch : color: "#B89E9E", width: 2, alpha: 0
  pulser :
    color : Color("#a6c4d2").lightenByRatio(0.1).toString()
    width : 0.4
    rays: _.map (new Array(15)), (item)->scale: 0

DEFAULT_ANIMATION= ->
  do screen= =>
    Tw @screen
      .to alpha: 1, 3000
      .delay 1000
      .easing E.Circular.Out
      .start()
  do pulser= =>
    _.each [0...@pulser.rays.length], (index)=>
      duration= _.random(3, 35)
      Tw @pulser.rays[index]
        .to scale: 1, duration * 1000
        .delay 1500
        .easing E.Circular.Out
        .start()
  do spannko= =>
    Tw @spannko
      .to alpha: 1, 1200
      .delay 4000
      .easing E.Linear.None
      .start()

export design_4=
  data: DEFAULT_DATA
  mounted: ->
    # 背景がすっと現れる
    Tw @screen
      .to alpha: 1, 1200
      .easing E.Cubic.In
      .delay 1000
      .start()

    # 背景が現れ終わったら、爆発が始まる
    _.each [0...@pulser.rays.length - 1], (index)=>
      Tw @pulser.rays[index]
        .to scale: 1, 4200
        .easing E.Circular.Out
        .delay 3000
        .start()

    # 最後のパルサーが走る(爆発が終わる直前)
    Tw @pulser.rays[@pulser.rays.length - 1]
        .to scale: 1, 800
        .easing E.Circular.Out
        .delay 6300
        .start()

    # ロゴ表示
    Tw @spannko
      .to alpha: 1, 1200
      .delay 8000
      .easing E.Linear.None
      .start()


export design_3=
  data: DEFAULT_DATA
  mounted: ->
    do screen= =>
      Tw @screen
        .to alpha: 1, 3000
        .delay 1000
        .easing E.Circular.Out
        .start()
    do pulser= =>
      _.each [0...@pulser.rays.length], (index)=>
        Tw @pulser.rays[index]
          .to scale: 1, 10000
          .delay 1500
          .easing E.Circular.Out
          .start()
    do spannko= =>
      Tw @spannko
        .to alpha: 1, 1200
        .delay 4000
        .easing E.Linear.None
        .start()

export design_2=
  data: ->
    screen: color: "#A71231", alpha: 0
    spannko: color: "#F1F1F1", width: 1, alpha: 0
    switch : color: "#B89E9E", width: 2, alpha: 0
    pulser:
      color: Color("#a6c4d2").lightenByRatio(0.1).toString()
      width: 0.6
      rays: _.map (new Array(15)), (item)->scale: 0

  mounted: ->
    new TWEEN.Tween @screen
      .to alpha: 1, 2000
      .delay 1000
      .easing TWEEN.Easing.Circular.Out
      .start()
    do pulser= =>
      _.each [0...@pulser.rays.length], (index)=>
        duration= _.random(3, 35)
        Tw @pulser.rays[index]
          .to scale: 1, duration * 1000
          .delay 1500
          .easing E.Circular.Out
          .start()

export design_1=
  data: DEFAULT_DATA
  mounted: DEFAULT_ANIMATION
