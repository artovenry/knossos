import orquestra from "./completed/orquestra"
ariadneString=[
  [Move, [-1, -4]]
  [A, [3, -6, 0], R]
  [A, [6, 12, 0], R]
  [A, [1, -2, 0], R]
  [A, [4, -8, 0], L]
  [A, [1, 2, 0], L]
  [A, [2, 4, 0], R]
  [A, [3, 6, 0], L]
  [A, [8,-16, 0], L]
  [A, [5, 5, 5], L]
  [A, [3, 0 ,6], R]
  [A, [11, -11, -11], R]
  [A, [14, 28, 0], R]
  [A, [9, -9, 9],R]
  [A, [1, 0, -2], R]
  [A, [7, 7, -7], L]
  [A, [12, -24, 0], L]
  [A, [9, 9, 9], L]
  [A, [1,0,-2], L]
  [A, [7, -7, -7], R]
  [A, [10, 20, 0], R]
  [A, [5, -5, 5], R]
  [A, [3, 0 , 6], L]
]
upperleft= [
  [Move, [-4, -4]]
  [A, [ 3,   6,   0], R]
  [A, [ 2,   4,   0], L]
  [A, [ 7, -14,   0], L]
  [A, [ 4,   4,   4], L]
  [Line, [ 8, 0]]
  [A, [ 4,   4,  -4], L]
  [A, [ 9, -18,   0], L]
  [A, [ 6,   6,   6], L]
  [A, [ 2,   0,   4], R]
  [A, [10, -10, -10], R]
  [A, [13,  26,   0], R]
  [A, [ 8,  -8,   8], R]
]
upperright=[
  [Move, [4, -4]]
  [A, [ 5,   -10,   0], L]
  [A, [2, 4,0], L]
  [A, [1, 2,0], R]
  [Line, [0 , 8]]
  [A, [4, -4, 4], R]
  [A, [12, -12, -12], R]
  [A, [15, 30, 0], R]
  [A, [10, -10, 10], R]
  [A, [2, 0 , -4], R]
  [A, [6, 6, -6], L]
  [A, [11, -22, 0], L]
  [A,[8, 8, 8], L]
]

export default
  animate: off
  frames: _.flatten _.values
    # ariadneString: d: ariadneString
    upperleft: d: upperleft
    upperright: d: upperright
    # orquestra: _.values(orquestra)
    # orquestra: [{d:***}, {d:***}, ...]
  , flat: true
