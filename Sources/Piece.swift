
protocol Piece {
    var color: Color { get }
    var icon: String { get }
    var symbol: String { get }
    var position: Position? { get set }
    var value: Int { get }

    // Returns all possible moves for the piece
    func calculateAllMoves(on board: Chessboard) -> [Move]

    func clone() -> Piece
}

extension Piece {
    // equatable
    func equals(other: Piece) -> Bool {
        return self.color == other.color && self.icon == other.icon && self.symbol == other.symbol
    }

    var isTaken: Bool {
        return position == nil
    }
}
