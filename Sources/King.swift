class King : Piece {
    var color: Color

    var icon: String

    var symbol: String

    var position: Position?

    func calculateAllMoves(on board: Chessboard) -> [Move] {
        guard let position = position else {
            return []
        }

        var moves = [Move]()

        if let newPos = position.get(offsetRow: 1, offsetColumn: 0) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -1, offsetColumn: 0) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 0, offsetColumn: 1) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 0, offsetColumn: -1) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 1, offsetColumn: 1) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 1, offsetColumn: -1) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -1, offsetColumn: 1) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -1, offsetColumn: -1) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        return moves
    }

    init(color: Color, position: Position) {
        self.color = color
        self.icon = color == .white ? "♔" : "♚"
        self.symbol = "K"
        self.position = position
    }
}