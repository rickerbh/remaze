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

let makeTop = columns => {
  // Use reduce to concat the strings
  // Or Js.Array.joinWith
  "+" ++
  Belt.Array.range(0, columns - 1)
  ->Belt.Array.map(_ => "---+")
  ->Belt.Array.reduce("", (acc, item) => acc ++ item) ++ "\n"
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

let mazeDisplay = (maze) => { 
  makeTop(Belt.Array.length(maze.cells) + 1) ++
  Belt.Array.map(maze.cells, makeRow)->Belt.Array.reduce("", (acc, item) => acc ++ item)
}

Console.log(mazeDisplay(maze))

type cellB = {
  row: int,
  column: int,
  opt?: string,
}

let aCell: cellB = {
  row: 0,
  column: 1,
}
