import SwiftUI

struct AnyShape: Shape {
    private let makePath: (CGRect) -> Path
    
    init<S: Shape>(_ wrapped: S) {
        makePath = { rect in
            wrapped.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        makePath(rect)
    }
}
