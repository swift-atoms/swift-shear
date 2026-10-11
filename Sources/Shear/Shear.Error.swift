extension Shear {
    public enum Error: Swift::Error, Equatable, Sendable {
        case invalidAxis
        case coincidentAxes
        case nonfiniteFactor
    }
}
