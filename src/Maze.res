type cell = {
  row: int,
  column: int,
  north: bool,
  south: bool,
  east: bool,
  west: bool,
}

type grid = {cells: array<array<cell>>}

let makeGrid = (rows, columns) => {
  let rs = Belt.Array.range(0, rows - 1)
  let cs = Belt.Array.range(0, columns - 1)
  let cells = rs->Belt.Array.map(ri => {
    cs->Belt.Array.map(ci => {
      row: ri,
      column: ci,
      north: false,
      south: false,
      east: false,
      west: false,
    })
  })
  {cells: cells}
}

// +---+---+---+ <- makeTop(3)
// |   |   |   | <- makeRow(row)
// +   +---+---+ <- (included in above)
// |       |   |
// +---+---+---+

// Below syntax is unexpected. The optional with default can't be in last position, so we can put
// unit () in that position.  If I was to reorder this so separator is first, and xs is second,
// and no unit, then the compiler complains about the lack of name being passed.
let joinWith = (xs, ~separator="", ()) => xs->Belt.Array.reduce(separator, (acc, x) => acc ++ x)

let makeTop = columns => {
  "+" ++ Belt.Array.range(0, columns - 1)->Belt.Array.map(_ => "---+")->joinWith() ++ "\n"
}

let makeRow = (row: array<cell>) => {
  row->Belt.Array.reduce("|", (acc, item) =>
    acc ++
    "   " ++ if item.east {
      " "
    } else {
      "|"
    }
  ) ++
  "\n" ++
  row->Belt.Array.reduce("+", (acc, item) =>
    acc ++
    if item.south {
      "   "
    } else {
      "---"
    } ++ "+"
  ) ++ "\n"
}

let maze = makeGrid(3, 4)

let mazeDisplay = maze => {
  let rows = maze.cells
  let columnCount = switch Belt.Array.get(rows, 0) {
  | Some(v) => Belt.Array.length(v)
  | None => 0
  }
  makeTop(columnCount) ++ Belt.Array.map(maze.cells, makeRow)->joinWith()
}

Console.log(mazeDisplay(maze))
