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