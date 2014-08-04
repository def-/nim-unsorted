import sets

const
  moves = 8
  knight: array[moves, tuple[x, y: int]] =
    [(1, 2), (1, -2), (2, 1), (2, -1), (-1, 2), (-1, -2), (-2, 1), (-2, -1)]
  start = 2
  board_size = 6
  bs2 = board_size * board_size

proc construct_graph: array[bs2, array[moves, int]] =
  for col in 0 .. <board_size:
    for row in 0 .. <board_size:
      let parent_id = col * board_size + row
      var i = 0
      for move in knight:
        let (x, y) = (row + move.x, col + move.y)
        if x in 0 .. <board_size and y in 0 .. <board_size:
          result[parent_id][i] = y * board_size + x
          inc i
      for i in i .. <moves:
        result[parent_id][i] = -1

const graph = construct_graph()

var path = @[start]
var found = path.toSet

proc knight_tour(root: int): bool =
  if path.len == board_size * board_size:
    return true

  for child in graph[root]:
    if child < 0: break
    if not found.contains(child):
      path.add child
      found.incl child
      if knight_tour(child):
        return true

  found.excl path[path.high]
  path.del path.high

discard knight_tour(start)
echo path
