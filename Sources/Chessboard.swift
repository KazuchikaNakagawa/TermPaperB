import Foundation

class Chessboard : CustomStringConvertible{
    var description: String {
        var board = ""
        for row in 1...8 {
            for column in 1...8 {
                if let piece = piece(at: Position(row: row, column: column)) {
                    board += piece.icon
                } else {
                    board += "·"
                }
            }
            board += "\n"
        }
        return board
    }

    private var board: [Piece] = []
    private var index = 0

    func piece(at position: Position) -> Piece? {
        return board.first { $0.position == position }
    }

    func execute(_ move: Move) {
        guard var piece = board.first(where: { $0.position == move.from }) else {
            return
        }

        piece.position = move.to
        move.capturedPiece?.position = nil
    }

    func undo(_ move: Move) {
        guard var piece = board.first(where: { $0.position == move.to }) else {
            return
        }

        piece.position = move.from
        if var takenPiece = move.capturedPiece {
            takenPiece.position = move.to
        }
    }

    init () {
        // add kings
        board.append(King(color: .white, position: Position(row: 1, column: 4)))
        board.append(King(color: .black, position: Position(row: 8, column: 4)))

        // add queens
        board.append(Queen(color: .white, position: Position(row: 1, column: 5)))
        board.append(Queen(color: .black, position: Position(row: 8, column: 5)))

        // add rooks
        board.append(Rook(color: .white, position: Position(row: 1, column: 1)))
        board.append(Rook(color: .white, position: Position(row: 1, column: 8)))
        board.append(Rook(color: .black, position: Position(row: 8, column: 1)))
        board.append(Rook(color: .black, position: Position(row: 8, column: 8)))

        // add bishops
        board.append(Bishop(color: .white, position: Position(row: 1, column: 3)))
        board.append(Bishop(color: .white, position: Position(row: 1, column: 6)))
        board.append(Bishop(color: .black, position: Position(row: 8, column: 3)))
        board.append(Bishop(color: .black, position: Position(row: 8, column: 6)))

        // add knights
        board.append(Knight(color: .white, position: Position(row: 1, column: 2)))
        board.append(Knight(color: .white, position: Position(row: 1, column: 7)))
        board.append(Knight(color: .black, position: Position(row: 8, column: 2)))
        board.append(Knight(color: .black, position: Position(row: 8, column: 7)))

        // add pawns
        for column in 1...8 {
            board.append(Pawn(color: .white, position: Position(row: 2, column: column)))
            board.append(Pawn(color: .black, position: Position(row: 7, column: column)))
        }
    }
}