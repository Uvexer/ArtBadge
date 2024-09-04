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
    
    func frameSize(for sizeType: SizeType) -> CGSize {
        switch (self, sizeType) {
        case (.circle, .large), (.square, .large):
            return CGSize(width: 500, height: 500)
        case (.circle, .medium), (.square, .medium):
            return CGSize(width: 300, height: 300)
        case (.circle, .small), (.square, .small):
            return CGSize(width: 100, height: 100)
        case (.rectangle, .large):
            return CGSize(width: 500, height: 300)
        case (.rectangle, .medium):
            return CGSize(width: 300, height: 200)
        case (.rectangle, .small):
            return CGSize(width: 100, height: 60)
        }
    }
}

enum SizeType {
    case large, medium, small
}
