enum Color {
    case white
    case black
}

extension Color {
    var opponent: Color {
        switch self {
        case .white: return .black
        case .black: return .white
        }
    }

    var direction: Int {
        switch self {
        case .white: return 1
        case .black: return -1
        }
    }
}

extension Color : CustomStringConvertible {
    var description: String {
        switch self {
        case .white: return "White"
        case .black: return "Black"
        }
    }
}