class ChessGame {
    private var currentTurnColor: Color = .white
    private var board: Chessboard
    private var moves: [Move] = []

    private var whitePlayer: Player
    private var blackPlayer: Player

    init(white whitePlayer: Player, black blackPlayer: Player) {
        board = Chessboard()
        self.whitePlayer = whitePlayer
        self.blackPlayer = blackPlayer
    }

    func start() {
        var whiteScore = 0.0
        var blackScore = 0.0
        while true {
            print(board)
            let player = currentTurnColor == .white ? whitePlayer : blackPlayer
            let move = player.makeChoice(in: board)
            if move.piece.color != currentTurnColor {
                print("Invalid move")
                continue
            }
            board.execute(move)
            if board.isCheckmate(for: currentTurnColor.opponent) {
                print("Checkmate")
                move.isCheckmate = true
                moves.append(move)
                if currentTurnColor == .white {
                    whiteScore += 1
                } else {
                    blackScore += 1
                }
                break
            }
            if board.isStalemate(for: currentTurnColor.opponent) {
                print("Stalemate")
                moves.append(move)
                whiteScore += 0.5
                blackScore += 0.5
                break
            }
            if board.isCheck(for: currentTurnColor) {
                print("avoid check...")
                board.undo(move)
                continue
            }
            if board.isCheck(for: currentTurnColor.opponent) {
                move.isCheck = true
            }
            moves.append(move)
            currentTurnColor = currentTurnColor.opponent
        }

        for move in moves {
            print(move.piece.color, ":", move)
        }
        print("\(whiteScore) - \(blackScore)")
    }
}