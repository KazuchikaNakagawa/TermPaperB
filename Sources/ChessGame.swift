import CoreFoundation

class ChessGame {
    private var currentTurnColor: Color = .white
    private var board: Chessboard
    private var moves: [Move] = []

    private var whitePlayer: Player
    private var blackPlayer: Player

    private var whitePlayerTime: Double = 0
    private var blackPlayerTime: Double = 0

    init(white whitePlayer: Player, black blackPlayer: Player) {
        board = Chessboard()
        self.whitePlayer = whitePlayer
        self.blackPlayer = blackPlayer
    }

    func start(with step: Bool = false) {
        var whiteScore = 0.0
        var blackScore = 0.0
        var allowedInvalidMoves = 10
        while true {
            print(board)
            let player = currentTurnColor == .white ? whitePlayer : blackPlayer
            let start = CFAbsoluteTimeGetCurrent()
            let move = player.makeChoice(in: board)
            let end = CFAbsoluteTimeGetCurrent()
            let time = end - start
            if currentTurnColor == .white {
                whitePlayerTime += time
            } else {
                blackPlayerTime += time
            }
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
                print(move, " is invalid, avoid check...", board.allPossibleMoves(for: currentTurnColor))
                allowedInvalidMoves -= 1
                
                board.undo(move)
                if allowedInvalidMoves == 0 {
                    board.execute(board.allPossibleMoves(for: currentTurnColor).randomElement()!)
                    allowedInvalidMoves = 10
                }else{
                    continue
                }
            }
            if board.isCheck(for: currentTurnColor.opponent) {
                move.isCheck = true
            }
            moves.append(move)
            currentTurnColor = currentTurnColor.opponent
            if step {
                print("Press enter to continue, q to quit")
                let cmd = readLine()
                if cmd == "q" {
                    break
                }
            }

            if let king = board.piece(suchThat: { $0 is King && $0.isTaken }).first {
                if king.color == .white {
                    print("Black wins")
                    blackScore += 1
                } else {
                    print("White wins")
                    whiteScore += 1
                }
                break
            }
        }

        for move in moves {
            print(move.piece.color, ":", move)
        }
        print("\(whiteScore) - \(blackScore)")
        print("White total thinking time: \(whitePlayerTime)")
        print("Black total thinking time: \(blackPlayerTime)")
        // reset time
        whitePlayerTime = 0
        blackPlayerTime = 0
    }
        
}