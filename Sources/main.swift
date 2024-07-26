import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst()
var player1: Player?
var player2: Player?

switch args[0] {
case "R":
    player1 = RandomPlayer(color: .white)
case "H":
    player1 = CLIPlayer(color: .white)
case "O":
    player1 = MinimaxPlayer(color: .white, evaluateAlgorithm: OffensiveAlgorithm(), depth: 3)
case "S":
    player1 = MinimaxPlayer(color: .white, evaluateAlgorithm: StrategicAlgorithm(), depth: 3)
default:
    player1 = RandomPlayer(color: .white)
}

assert(args[1] == "vs")

switch args[2] {
case "R":
    player2 = RandomPlayer(color: .black)
case "H":
    player2 = CLIPlayer(color: .black)
case "O":
    player2 = MinimaxPlayer(color: .black, evaluateAlgorithm: OffensiveAlgorithm(), depth: 3)
case "S":
    player2 = MinimaxPlayer(color: .black, evaluateAlgorithm: StrategicAlgorithm(), depth: 3)
default:
    player2 = RandomPlayer(color: .black)
}

let game = ChessGame(white: player1!, black: player2!)
game.start(with: args.last == "--step")