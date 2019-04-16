funnyAriadnePaths=[
  ["m", [0, 0]]
  ["al", [15, 15, 15, -15]]
  ["al", [15, 15, 15, 15]]
  ["al", [30, 30, -60, 0]]
  ["al", [5 ,  5, 10, 0]]
  ["ar", [20, 20,  40, 0]]
  ["ar", [5 ,  5,   -10, 0]]
  ["al", [10, 10,  -20, 0]]
  ["ar", [15, 15,  -15, -15]]
  ["ar", [15, 15,   -15, 15]]
  ["ar", [40, 40,  80,   0]]
  ["ar", [25, 25,   -25,  -25]]
  ["al", [15, 15,   0,   -30]]
  ["al", [55, 55,  55, 55]]
  ["al", [70, 70,  -140,   0]]
  ["al", [45, 45,  45,  -45]]
  ["al", [ 5,  5,    0, 10]]
  ["ar", [35, 35,   -35, 35]]
  ["ar", [60, 60, 120,   0]]
  ["ar", [45, 45,   -45,  -45]]
  ["ar", [ 5,  5,    0, 10]]
  ["al", [35, 35,  35, 35]]
  ["al", [50, 50,   -100,  0]]
  ["al", [25, 25,  25, -25]]
  ["ar", [15, 15, 0, -30]]
]
paths=
  fromUpperLeft:
    commands: [
      ["m", [-15, 0]]
      ["ar", [15, 15, 30, 0]]
      ["al", [10, 10, 20, 0]]
      ["al", [35, 35, -70, 0]]
      ["al", [20, 20, 20, 20]]
      ["h", 40]
      # ["m", [40, 0]]

      # ["al", [20, 20, 20, -20]]
      # ["al", [20, 20, 20,  20]]
      # ["al", [20, 20, -20, 20]]
      # ["al", [20, 20, -20, -20]]
      # ["al", [20, 20, 20, -20]]
      # ["al", [20, 20, 20,  20]]


      ["al", [20, 20,  20, -20]]
      ["al", [45, 45, -90,   0]]
      ["al", [30, 30,  30,  30]]
      ["ar", [10, 10,   0,  20]]
      ["ar", [50, 50, -50, -50]]
      ["ar", [65, 65, 130,   0]]
      ["ar", [40, 40, -40,  40]]
    ]
    length: 856.88
  fromUpperRight:
    commands: [
      ["m", [25,  0]]
      ["al", [25, 25, -50,   0]]
      ["al", [10, 10,  20,   0]]
      ["ar", [ 5,  5,  10,   0]]
      ["v",  40]
      # ["m", [0, 40]]
      # ["al", [20, 20, 20,  20]]
      # ["al", [20, 20, -20, 20]]
      # ["al", [20, 20, -20, -20]]
      # ["al", [20, 20, 20, -20]]
      # ["al", [20, 20, 20,  20]]
      # ["al", [20, 20, -20, 20]]

      ["ar", [20, 20, -20,  20]]
      ["ar", [60, 60, -60, -60]]
      ["ar", [75, 75, 150,   0]]
      ["ar", [50, 50, -50,  50]]
      ["ar", [10, 10,   0, -20]]
      ["al", [30, 30,  30, -30]]
      ["al", [55, 55,-110,   0]]
      ["al", [40, 40,  40,  40]]
    ]
    length: 919.77
  ariadne:
    commands: [
      ["m", [0, 0]]
      ["ar", [15, 15, -15, 15]]
      ["ar", [15, 15, -15, -15]]
      ["ar", [30, 30, 60, 0]]
      ["ar", [5 ,  5, -10, 0]]
      ["al", [20, 20,  -40, 0]]
      ["al", [5 ,  5,   10, 0]]
      ["ar", [10, 10,  20, 0]]
      ["al", [15, 15,  15, 15]]
      ["al", [15, 15,   15, -15]]
      ["al", [40, 40,  -80,   0]]
      ["al", [25, 25,   25,  25]]
      ["ar", [15, 15,   0,   30]]
      ["ar", [55, 55,  -55, -55]]
      ["ar", [70, 70,  140,   0]]
      ["ar", [45, 45,  -45,  45]]
      ["ar", [ 5,  5,    0, -10]]
      ["al", [35, 35,   35, -35]]
      ["al", [60, 60, -120,   0]]
      ["al", [45, 45,   45,  45]]
      ["al", [ 5,  5,    0, -10]]
      ["ar", [35, 35,  -35, -35]]
      ["ar", [50, 50,   100,  0]]
      ["ar", [25, 25,  -25, 25]]
      ["al", [15, 15, 0, 30]]
      ["al", [55, 55, 55, -55]]
    ]
    length: 1547.4

import {RATIO, KNOSSOS_ORIGIN} from "./constants"
draw= (data)->
  dataToCommand= (data)->
    ratio = RATIO ? 1
    switch data[0]
      when "m"
        "m #{data[1][0] * ratio} #{data[1][1] * ratio}"
      when "v"
        "v #{data[1] * ratio}"
      when "h"
        "h #{data[1] * ratio}"
      when "al"
        "a #{data[1][0] * ratio} #{data[1][1] * ratio} 0 0 0 #{data[1][2] * ratio} #{data[1][3] * ratio}"
      when "ar"
        "a #{data[1][0] * ratio} #{data[1][1] * ratio} 0 0 1 #{data[1][2] * ratio} #{data[1][3] * ratio}"
  origin= "M #{KNOSSOS_ORIGIN.x} #{KNOSSOS_ORIGIN.y}"
  # origin= ""
  cmds= data.map dataToCommand
  cmds.unshift origin; cmds.join(" ")

export default (curve= no)->
  fromUpperLeft: draw(paths.fromUpperLeft.commands)
  fromUpperRight: draw(paths.fromUpperRight.commands)
  ariadne: draw(paths.ariadne.commands)
