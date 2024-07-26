class Bishop : Piece {
    func clone() -> any Piece {
        return Bishop(color: color, position: position) 
    }

    var value: Int {
        return 3
    }

    var color: Color

    var icon: String

    var symbol: String

    var position: Position?

    func calculateAllMoves(on board: Chessboard) -> [Move] {
        guard let position = position else {
            return []
        }
        var moves = [Move]()
        var offset = 1;
        while let newPos = position.get(offsetRow: offset, offsetColumn: offset) {
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
        while let newPos = position.get(offsetRow: offset, offsetColumn: -offset) {
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
        while let newPos = position.get(offsetRow: -offset, offsetColumn: offset) {
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
        while let newPos = position.get(offsetRow: -offset, offsetColumn: -offset) {
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

    init(color: Color, position: Position?) {
        self.color = color
        self.position = position
        self.icon = color == .white ? "♗" : "♝"
        self.symbol = "B"
    }
}