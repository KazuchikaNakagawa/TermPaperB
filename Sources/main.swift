// The Swift Programming Language
// https://docs.swift.org/swift-book

// let chessboard = Chessboard()
// guard let piece = chessboard.piece(suchThat: {
//     piece in
//     return piece.symbol == "B" && piece.position?.row == 1 && piece.position?.column == 3
// }).first else {
//     fatalError("Piece not found")
// }

// guard let pawn1 = chessboard.piece(suchThat: {
//     piece in
//     return piece.symbol == "" && piece.position == Position(row: 2, column: "d")
// }).first else {
//     fatalError("Piece not found")
// }
// let move = pawn1.calculateAllMoves(on: chessboard)[1]
// chessboard.execute(move)

// print(piece.calculateAllMoves(on: chessboard))
// print(chessboard)

// print("Moves from String Test")

// chessboard.execute(Move("e5", on: chessboard)!)
// chessboard.execute(Move("Bf4", on: chessboard)!)
// let move2 = Move("dxe5", on: chessboard)!
// chessboard.execute(move2)

// print(chessboard)

// chessboard.undo(move2)

// print(chessboard)

let player1 = CLIPlayer(color: .white)
let player2 = CLIPlayer(color: .black)

let game = ChessGame(white: player1, black: player2)
game.start()