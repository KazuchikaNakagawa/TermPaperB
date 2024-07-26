import Foundation

protocol Player {
    func makeChoice(in board: Chessboard) -> Move
}

class CLIPlayer: Player {
    var playerColor: Color

    func makeChoice(in board: Chessboard) -> Move {
        print(playerColor, ": make a move")
        let input = readLine()!
        if let move = Move(input, on: board, by: playerColor) {
            return move
        }else{
            print(playerColor, ": invalid move")
            return makeChoice(in: board)
        }
    }

    init(color: Color) {
        playerColor = color
    }
}

class RandomPlayer: Player {
    var playerColor: Color

    func makeChoice(in board: Chessboard) -> Move {
        let moves = board.allPossibleMoves(for: playerColor)
        return moves.randomElement()!
    }

    init(color: Color) {
        playerColor = color
    }
}

protocol EvaluateAlgorithm {
    func evaluate(board: Chessboard, for color: Color) -> Double
}

class MinimaxPlayer: Player {
    var playerColor: Color
    var evaluateAlgorithm: EvaluateAlgorithm
    var depth: Int

    func makeChoice(in board: Chessboard) -> Move {
        let moves = board.allPossibleMoves(for: playerColor)
        var bestMoves: [Move] = []
        var bestScore = -Double.infinity
        let semaphore = DispatchSemaphore(value: 0)
        // semaphore.wait()
        let queue = DispatchQueue.global()// (label: "chess.makeChoice")
        let group = DispatchGroup()
        for move in moves {
            group.enter()
            queue.async {
                let board = board.clone()
                board.execute(move)
                let score = self.minimax(board: board, depth: self.depth, isMaximizing: false)
                board.undo(move)
                print(move, " is:", score)
                if (score > bestScore) {
                    bestScore = score
                    bestMoves = [move]
                }else if score == bestScore {
                    bestMoves.append(move)
                }
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.global()) {
            semaphore.signal()
        }
        semaphore.wait()
        print(bestScore, bestMoves)
        return bestMoves.randomElement()!
    }

    func minimax(board: Chessboard, depth: Int, isMaximizing: Bool) -> Double {
        if depth == 0 {
            return evaluateAlgorithm.evaluate(board: board, for: playerColor)
        }

        let board = board.clone()

        let moves = board.allPossibleMoves(for: isMaximizing ? playerColor : playerColor.opponent)
        if isMaximizing {    
            var bestScore = -Double.infinity
            for move in moves {
                let board = board.clone()
                board.execute(move)
                let score = self.minimax(board: board, depth: depth - 1, isMaximizing: !isMaximizing)
                board.undo(move)
                
                bestScore = max(score, bestScore)
            }
            
            return bestScore
        } else {
            var bestScore = Double.infinity
            for move in moves {
                let board = board.clone()
                board.execute(move)
                let score = self.minimax(board: board, depth: depth - 1, isMaximizing: !isMaximizing)
                board.undo(move)
                
                bestScore = min(score, bestScore)
            }
            return bestScore
        }
    }

    init(color: Color, evaluateAlgorithm: EvaluateAlgorithm, depth: Int) {
        playerColor = color
        self.evaluateAlgorithm = evaluateAlgorithm
        self.depth = depth
    }
}

class StrategicAlgorithm: EvaluateAlgorithm {
    func evaluate(board: Chessboard, for color: Color) -> Double {
        if board.piece(suchThat: { $0.symbol == "K" && !$0.isTaken && $0.color == color}).isEmpty {
            return -Double.infinity
        }
        
        let myMoves = board.allPossibleMoves(for: color).count
        let opponentMoves = board.allPossibleMoves(for: color.opponent).count
        return Double(myMoves - opponentMoves)
    }
}

class OffensiveAlgorithm: EvaluateAlgorithm {
    func evaluate(board: Chessboard, for color: Color) -> Double {
        if board.piece(suchThat: { $0.symbol == "K" && !$0.isTaken && $0.color == color }).isEmpty {
            return -Double.infinity
        }
        let myPieces = board.piece(suchThat: { $0.color == color && !$0.isTaken }).map { !$0.isTaken ? $0.value : 0 }
        let valueSum = myPieces.reduce(0, +)
        let opponentPieces = board.piece(suchThat: { $0.color == color.opponent && !$0.isTaken }).map { !$0.isTaken ? $0.value : 0 }
        let opponentValueSum = opponentPieces.reduce(0, +)
        return Double(valueSum - opponentValueSum)
    }
}