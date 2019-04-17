_.mixin sum: (collection, iteratee, from, to)->
 args= _.toArray(arguments)
 collection= args.shift()
 if _.isFunction (iterat= args.shift())
  [from, to]= [args.shift() ? 0, args.shift() ? -1]
 else
  [from, to]= [iterat ? 0, args.shift() ? -1]
  iterat= _.identity
 _.inject collection, (memo, item ,index)->
  if to is -1
   if from <= index then memo + (+iterat(item, index)) else memo
  else
   if (from <= index and index <= to) then memo + (+iterat(item, index)) else memo
 , 0
