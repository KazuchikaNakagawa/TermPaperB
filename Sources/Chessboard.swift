import Foundation

class Chessboard : CustomStringConvertible{
    var description: String {
        var board = ""
        for row in (1...8).reversed() {
            for column in (1...8) {
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

    func piece(suchThat predicate: (Piece) -> Bool) -> [Piece] {
        return board.filter(predicate)
    }

    func execute(_ move: Move) {
        guard var piece = board.first(where: { $0.position == move.from }) else {
            print("consistency error: piece not found")
            return
        }

        if move.capturedPiece == nil {
            piece.position = move.to
            return
        }
        guard var takenPiece = board.first(where: { $0.position == move.to }) else {
            print("consistency error: piece not found")
            return
        }
        takenPiece.position = nil
        piece.position = move.to
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

    func allPossibleMoves(for color: Color) -> [Move] {
        return board.filter { $0.color == color }.flatMap { $0.calculateAllMoves(on: self) }
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

    required init(board: Chessboard) {
        self.board = board.board.map { $0.clone() }
    }

    func isCheck(for color: Color) -> Bool {
        let king = board.first { $0 is King && $0.color == color }!
        return board.contains { piece in
            piece.color != color && piece.calculateAllMoves(on: self).contains { $0.to == king.position }
        }
    }

    func isCheckmate(for color: Color) -> Bool {
        return isCheck(for: color) && board.filter { $0.color == color }.allSatisfy { piece in
            piece.calculateAllMoves(on: self).allSatisfy { move in
                execute(move)
                let isCheck = isCheck(for: color)
                undo(move)
                return isCheck
            }
        }
    }

    func isStalemate(for color: Color) -> Bool {
        return !isCheck(for: color) && board.filter { $0.color == color }.allSatisfy { piece in
            piece.calculateAllMoves(on: self).count == 0
        }
    }

    func clone() -> Self {
        return Self.init(board: self)
    }
}