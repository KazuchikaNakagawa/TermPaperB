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