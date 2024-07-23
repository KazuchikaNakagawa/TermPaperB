
protocol MoveDelegate {
    func onMoved(move: Move, in board: Chessboard)
}

class Move : CustomStringConvertible{
    var description: String {
        return "\(piece.symbol)\(annotation)\(capturedPiece != nil ? "x" : "")\(to)\(isCheck ? "+" : "")\(isCheckmate ? "#" : "")\(promotion != nil ? "=\(promotion!.symbol)" : "")"
    }

    var delegate: MoveDelegate?

    let piece: Piece
    let from: Position
    let to: Position
    var capturedPiece: Piece?
    let isCheck: Bool
    let isCheckmate: Bool
    let promotion: Piece?

    let annotation: String
    init(piece: Piece, 
    from: Position, 
    to: Position, 
    capturedPiece: Piece? = nil, 
    isCheck: Bool = false, 
    isCheckmate: Bool = false,
    annotation: String = "",
    promotion: Piece? = nil) {
        self.piece = piece
        self.from = from
        self.to = to
        self.capturedPiece = capturedPiece
        self.isCheck = isCheck
        self.isCheckmate = isCheckmate
        self.annotation = annotation
        self.promotion = promotion
    }
}