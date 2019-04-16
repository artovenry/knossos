  firstAnimation:
    origin: [50, 48]
    frames: sfv
      1:
        dur: 1000
        begin: 0
        d:[
          [V, -3]
        ]
      2: _.values
        1:
          dur: 2000, begin: 1000
          d:[
            [u, 3],[V, -3]
          ]
        2:
          dur: 2000, begin: 1000
          d:[
            [u, 3], [H,  4], [A, [3, 3, -3], L]
          ]
        3:
          dur: 2000, begin: 1000
          d:[
            [u, 3],  [H, -4], [A, [3, -3, -3], R]
          ]
      3: _.values
        1:
          tag: "birthOfO"
          dur: 2000
          d:[
            [Move, [-7, -6]], [A, [3, 6, 0], R]
          ]

  birthOfO:
    origin: [49, 42]
    frames: sfv
      1:
        begin: "birthOfO"
        d: [
          [A,[3, -3, 3], R]
        ]
