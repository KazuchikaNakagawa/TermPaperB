class Rook : Piece {
    var color: Color

    var icon: String

    var symbol: String

    var position: Position?

    func calculateAllMoves(on board: Chessboard) -> [Move] {
        guard let position = position else {
            return []
        }
        var moves = [Move]()
        var offset = 1

        while let newPos = position.goStraight(of: color, by: offset) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
                break
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
            offset += 1
        }

        offset = 1
        while let newPos = position.goStraight(of: color, by: -offset) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
                break
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
            offset += 1
        }

        offset = 1
        while let newPos = position.get(offsetRow: 0, offsetColumn: offset) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
                break
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
            offset += 1
        }

        offset = 1
        while let newPos = position.get(offsetRow: 0, offsetColumn: -offset) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
                break
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
            offset += 1
        }

        return moves
    }

    init(color: Color, position: Position) {
        self.color = color
        self.position = position
        self.icon = color == .white ? "♖" : "♜"
        self.symbol = "R"
    }

}