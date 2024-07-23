
struct Position : CustomStringConvertible, Equatable {
    var description: String {
        return "\(Position.indexToColumn(column))\(row)"
    }

    var row: Int
    var column: Int

    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }

    init(row: Int, column: Character) {
        self.row = row
        self.column = Position.columnToIndex(column)
    }

    static func columnToIndex(_ column: Character) -> Int {
        let index = Array("abcdefgh").firstIndex(of: column)
        assert(index != nil)
        return index! + 1
    }

    static func indexToColumn(_ index: Int) -> Character {
        assert(index >= 1 && index < 8)
        return Array("abcdefgh")[index-1]
    }

    func goStraight(of side: Color, by offset: Int) -> Position? {
        let newRow = row + side.direction * offset
        if newRow < 1 || newRow > 8 {
            return nil
        }
        return Position(row: newRow, column: column)
    }

    func goDiagonalRight(of side: Color, by offset: Int) -> Position? {
        let newRow = row + side.direction * offset
        let newColumn = column + offset
        if newRow < 1 || newRow > 8 || newColumn < 1 || newColumn > 8 {
            return nil
        }
        return Position(row: newRow, column: newColumn)
    }

    func goDiagonalLeft(of side: Color, by offset: Int) -> Position? {
        let newRow = row + side.direction * offset
        let newColumn = column - offset
        if newRow < 1 || newRow > 8 || newColumn < 1 || newColumn > 8 {
            return nil
        }
        return Position(row: newRow, column: newColumn)
    }

    func get(offsetRow: Int, offsetColumn: Int) -> Position? {
        let newRow = row + offsetRow
        let newColumn = column + offsetColumn
        if newRow < 1 || newRow > 8 || newColumn < 1 || newColumn > 8 {
            return nil
        }
        return Position(row: newRow, column: newColumn)
    }

    // implement Equatable
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}