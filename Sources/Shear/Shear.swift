@_exported public import Axis
@_exported public import Scale

public struct Shear<let N: Int, Scalar: BinaryFloatingPoint> {
    public let target: Axis<N>
    public let source: Axis<N>
    public let factor: Scale<1, Scalar>

    public enum Error: Swift.Error, Equatable, Sendable {
        case invalidAxis
        case coincidentAxes
        case nonfiniteFactor
    }

    public init(target: Axis<N>, source: Axis<N>, factor: Scale<1, Scalar>) throws(Error) {
        guard target.underlying >= 0, target.underlying < N,
              source.underlying >= 0, source.underlying < N else { throw .invalidAxis }
        guard target != source else { throw .coincidentAxes }
        guard factor.value.isFinite else { throw .nonfiniteFactor }
        self.target = target
        self.source = source
        self.factor = Scale(factor.value == 0 ? 0 : factor.value)
    }

    public var inverse: Self {
        Self(validatedTarget: target, source: source, factor: -factor.value)
    }

}

extension Shear: Equatable {}
extension Shear: Hashable where Scalar: Hashable {}
extension Shear: Sendable where Scalar: Sendable {}

#if !hasFeature(Embedded)
extension Shear {
    private enum CodingKeys: String, CodingKey { case target, source, factor }
}
extension Shear: Encodable where Scalar: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(target.underlying, forKey: .target)
        try c.encode(source.underlying, forKey: .source)
        try c.encode(factor.value, forKey: .factor)
    }
}
extension Shear: Decodable where Scalar: Decodable {
    public init(from decoder: any Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        let target = try c.decode(Int.self, forKey: .target)
        let source = try c.decode(Int.self, forKey: .source)
        let factor = try c.decode(Scalar.self, forKey: .factor)
        do {
            try self.init(target: Axis(target), source: Axis(source), factor: Scale(factor))
        } catch {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath,
                debugDescription: "A shear requires distinct valid axes and a finite factor"))
        }
    }
}
#endif

extension Shear {
    private init(validatedTarget: Axis<N>, source: Axis<N>, factor: Scalar) {
        self.target = validatedTarget
        self.source = source
        self.factor = Scale(factor == 0 ? 0 : factor)
    }
}
