class Knight : Piece{
    var color: Color

    var icon: String

    var symbol: String

    var position: Position?

    func calculateAllMoves(on board: Chessboard) -> [Move] {
        guard let position = position else {
            return []
        }
        var moves = [Move]()
        if let newPos = position.get(offsetRow: 1, offsetColumn: color.direction * 2) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -1, offsetColumn: color.direction * 2) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 2, offsetColumn: color.direction) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -2, offsetColumn: color.direction) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 1, offsetColumn: -color.direction * 2) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -1, offsetColumn: -color.direction * 2) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: 2, offsetColumn: -color.direction) {
            if let piece = board.piece(at: newPos) {
                if piece.color != color {
                    moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: piece))
                }
            } else {
                moves.append(Move(piece: self, from: position, to: newPos, capturedPiece: nil))
            }
        }

        if let newPos = position.get(offsetRow: -2, offsetColumn: -color.direction) {
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
        self.position = position
        self.icon = color == .white ? "♘" : "♞"
        self.symbol = "N"
    }
}