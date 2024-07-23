class Pawn : Piece {

    private func canGoStraight(on board: Chessboard) -> Bool {
        guard let position = position else {
            return false
        }
        if let newPos = position.goStraight(of: color, by: 1) {
            if board.piece(at: newPos) == nil {
                return true
            }
        }
        return false
    }

    private func canTakeRight(on board: Chessboard) -> Bool {
        guard let position = position else {
            return false
        }
        guard let newPos = position.goDiagonalRight(of: color, by: 1) 
        else { return false }

        if let piece = board.piece(at: newPos) {
            return piece.color != color
        }
        return false
    }

    private func canTakeLeft(on board: Chessboard) -> Bool {
        guard let position = position else {
            return false
        }
        guard let newPos = position.goDiagonalLeft(of: color, by: 1) 
        else { return false }

        if let piece = board.piece(at: newPos) {
            return piece.color != color
        }
        return false
    }

    private func canGoJump(on board: Chessboard) -> Bool {
        guard let position = position else {
            return false
        }
        if position.row != (color == .white ? 2 : 7) {
            return false
        }
        if let newPos = position.goStraight(of: color, by: 2) {
            if board.piece(at: newPos) == nil {
                return true
            }
        }
        return false
    }

    func calculateAllMoves(on board: Chessboard) -> [Move] {
        guard let position = position else {
            return []
        }
        var moves: [Move] = []
        
        if canGoStraight(on: board) {
            moves.append(Move(piece: self, from: position, to: position.goStraight(of: color, by: 1)!, capturedPiece: nil))
        }

        if canGoJump(on: board) {
            moves.append(Move(piece: self, from: position, to: position.goStraight(of: color, by: 2)!, capturedPiece: nil))
        }

        if canTakeRight(on: board) {
            moves.append(
                Move(
                    piece: self, 
                    from: position, 
                    to: position.goDiagonalRight(of: color, by: 1)!, 
                    capturedPiece: board.piece(at: position.goDiagonalRight(of: color, by: 1)!),
                    annotation: String(Position.indexToColumn(position.column))))
        }

        if canTakeLeft(on: board) {
            moves.append(
                Move(
                    piece: self, 
                    from: position, 
                    to: position.goDiagonalLeft(of: color, by: 1)!, 
                    capturedPiece: board.piece(at: position.goDiagonalLeft(of: color, by: 1)!),
                    annotation: String(Position.indexToColumn(position.column))))
        }

        return moves
    }

    var color: Color

    var icon: String

    var symbol: String

    var position: Position?

    private var movedIndex = 0

    init(color: Color, position: Position) {
        self.color = color
        self.position = position
        self.icon = color == .white ? "♙" : "♟"
        self.symbol = ""
    }
}