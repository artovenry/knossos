<template lang="pug">
  #labyrinth
    svg(:viewBox="viewBox" width="544px" style="border: 1px solid #AAA;margin: 10%")
      circle(
        fill="black"
        :cx="14 * ratio"  :cy="17 * ratio"  r="4"
      )
      path.upperleft(
        fill="none"
        stroke="black"
        :d="upperleft.cmds"
      )
      circle(
        fill="red"
        :cx="22 * ratio"  :cy="17 * ratio"  r="4"
      )
      path.upperright(
        fill="none"
        stroke="red"
        :d="upperright.cmds"
      )
</template>
<script lang="coffee">
  RATIO= 16
  PRIMITIVE=
    margin: 2
    width: 30, height: 27
    upperleft: """
      M 14 17
      a  3  3 0 0 1   6   0
      a  2  2 0 0 0   4   0
      a  7  7 0 0 0 -14   0
      a  4  4 0 0 0   4   4
      l  8  0
      a  4  4 0 0 0   4  -4
      a  9  9 0 0 0 -18   0
      a  6  6 0 0 0   6   6
      a  2  2 0 0 1   0   4
      a 10 10 0 0 1 -10 -10
      a 13 13 0 0 1  26   0
      a  8  8 0 0 1  -8   8
    """
    upperright: """
      M 22 17
      a  5  5 0 0 0 -10   0
      a  2  2 0 0 0   4   0
      a  1  1 0 0 1   2   0
      l  0  8
      a  4  4 0 0 1  -4   4
      a 12 12 0 0 1 -12 -12
      a 15 15 0 0 1  30   0
      a 10 10 0 0 1 -10  10
      a  2  2 0 0 1   0  -4
      a  6  6 0 0 0   6  -6
      a 11 11 0 0 0 -22   0
      a  8  8 0 0 0   8   8
    """
  realCmds= (cmds)->scaleCmds(cmds, RATIO)
  scaleCmds= (cmds, ratio)->
    items= cmds.split("\n")
    items= _.map items, (item)->
      nums= item.slice(1)
      nums = _.compact nums.split(" ")
      cmd = item.substr(0,1)
      nums = _.map nums, (item, index)->
        if cmd is "a"
          if 2 <= index and index <= 4 then item else (+item) * ratio
        else
          (+item) * ratio
      "#{cmd} #{nums.join(" ")}"
    items.join (" ")

  export default
    data: ->
      viewBox: "0 0 #{(PRIMITIVE.width + PRIMITIVE.margin * 2) * RATIO} #{(PRIMITIVE.height + PRIMITIVE.margin * 2) * RATIO}"
      ratio: RATIO
      upperleft:
        cmds: realCmds(PRIMITIVE.upperleft)
      upperright:
        cmds: realCmds(PRIMITIVE.upperright)
</script>
