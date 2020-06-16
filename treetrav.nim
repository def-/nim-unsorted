import deques

type
  Node[T] = ref TNode[T]
  TNode[T] = object
    data: T
    left, right: Node[T]

proc newNode[T](data: T; left, right: Node[T] = nil): Node[T] =
  Node[T](data: data, left: left, right: right)

proc preorder[T](n: Node[T]): seq[T] =
  if n == nil: @[]
  else: @[n.data] & preorder(n.left) & preorder(n.right)

proc inorder[T](n: Node[T]): seq[T] =
  if n == nil: @[]
  else: inorder(n.left) & @[n.data] & inorder(n.right)

proc postorder[T](n: Node[T]): seq[T] =
  if n == nil: @[]
  else: postorder(n.left) & postorder(n.right) & @[n.data]

proc levelorder[T](n: Node[T]): seq[T] =
  result = @[]
  var queue = initDeque[Node[T]]()
  queue.addLast(n)
  while queue.len > 0:
    let next = queue.popFirst()
    result.add next.data
    if next.left != nil: queue.addLast(next.left)
    if next.right != nil: queue.addLast(next.right)

let tree = 1.newNode(
             2.newNode(
               4.newNode(
                 7.newNode),
               5.newNode),
             3.newNode(
               6.newNode(
                 8.newNode,
                 9.newNode)))

echo preorder tree
echo inorder tree
echo postorder tree
echo levelorder tree
