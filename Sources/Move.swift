
class Move : CustomStringConvertible{
    var description: String {
        return "\(piece.symbol)\(annotation)\(capturedPiece != nil ? "x" : "")\(to)\(isCheck ? "+" : "")\(isCheckmate ? "#" : "")"
    }

    let piece: Piece
    let from: Position
    let to: Position
    var capturedPiece: Piece?
    var isCheck: Bool
    var isCheckmate: Bool

    let annotation: String
    init(piece: Piece, 
    from: Position, 
    to: Position, 
    capturedPiece: Piece? = nil, 
    isCheck: Bool = false, 
    isCheckmate: Bool = false,
    annotation: String = "") {
        self.piece = piece
        self.from = from
        self.to = to
        self.capturedPiece = capturedPiece
        self.isCheck = isCheck
        self.isCheckmate = isCheckmate
        self.annotation = annotation
    }

    init?(_ code: String, on board: Chessboard, by color: Color) {
        // print("Move code: \(code)")
        
        guard code.count >= 2 else {
            print("Invalid move code, too short")
            return nil
        }
        
        var code = String(code.reversed())
        guard let rowC = code.first else {
            print("row is not the last")
            return nil
        }
        guard rowC.isNumber else {
            print("row is not a number")
            return nil
        }

        let row = Int(String(rowC))!
        code.removeFirst()

        guard let columnC = code.first else {
            print("column is not there")
            return nil
        }

        guard columnC.isLowercase else {
            print("column is not a letter")
            return nil
        }

        let column = Position.columnToIndex(columnC)
        code.removeFirst()

        var takenPiece: Piece? = nil
        if let next = code.first {
            if next == "x" {
                code.removeFirst()
                guard let piece = board.piece(at: Position(row: row, column: column)) else {
                    print("it should take a piece")
                    return nil
                }
                takenPiece = piece
            }
        }

        var rowAnnotation: Int? = nil
        var columnAnnotation: Int? = nil
        var pieceSymbol = ""
        if let next = code.first {
            if next.isUppercase {
                pieceSymbol = String(next)
                code.removeFirst()
            }
            else if next.isLowercase {
                columnAnnotation = Position.columnToIndex(next)
                code.removeFirst()
                pieceSymbol = code.first != nil ? String(code.removeFirst()) : ""
            }
            else if next.isNumber {
                rowAnnotation = Int(String(next))
                code.removeFirst()
                pieceSymbol = code.first != nil ? String(code.removeFirst()) : ""
            }else{
                print("Invalid annotation")
                return nil
            }
        }

        assert(code.isEmpty)
        var pieces = board.piece(suchThat: {
            (piece) in
            if piece.color != color {
                return false
            }
            if piece.symbol != pieceSymbol {
                return false
            }

            return piece.calculateAllMoves(on: board).contains(where: {
                move in
                return move.to == Position(row: row, column: column)
            })
        })

        if pieces.count == 1 {
            self.piece = pieces[0]
            self.from = pieces[0].position!
            self.to = Position(row: row, column: column)
            self.capturedPiece = takenPiece
            self.isCheck = false
            self.isCheckmate = false
            self.annotation = (rowAnnotation != nil ? String(rowAnnotation!) : "") + (columnAnnotation != nil ? String(Position.indexToColumn(columnAnnotation!)) : "")
        }else{
            pieces = pieces.filter {
                piece in
                return piece.position!.row == rowAnnotation || piece.position!.column == columnAnnotation
            }

            if pieces.count == 1 {
                self.piece = pieces[0]
                self.from = pieces[0].position!
                self.to = Position(row: row, column: column)
                self.capturedPiece = takenPiece
                self.isCheck = false
                self.isCheckmate = false
                self.annotation = (rowAnnotation != nil ? String(rowAnnotation!) : "") + (columnAnnotation != nil ? String(Position.indexToColumn(columnAnnotation!)) : "")
            }else{
                print("Invalid move code, too many pieces")
                return nil
            }

        }
    }
}