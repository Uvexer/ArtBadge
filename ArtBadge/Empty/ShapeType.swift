import SwiftUI

enum ShapeType {
    case circle, square, rectangle
    
    var shape: AnyShape {
        switch self {
        case .circle:
            return AnyShape(Circle())
        case .square:
            return AnyShape(Rectangle())
        case .rectangle:
            return AnyShape(Rectangle())
        }
    }
    
    func frameSize() -> CGSize {
        switch self {
        case .circle, .square:
            return CGSize(width: 300, height: 300)
        case .rectangle:
            return CGSize(width: 300, height: 200)
        }
    }
}

