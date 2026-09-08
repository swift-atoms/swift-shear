# Shear

An elementary coordinate shear defined by distinct Axis<N> values and a finite
Scale factor: target += factor * source. Axes and factor constitute the value.
Construction validates axes (including unchecked Axis values) and factor finiteness.
Inverse preserves axes and negates the factor. Zero factors are valid identities;
equality preserves axes and factor even for zero. Coding validates decoded values.

```swift
import Shear
let shear = try Shear<2, Double>(
    target: .primary, source: .secondary, factor: Scale(2)
)
let inverse = shear.inverse
```

Core URL dependencies are Axis and Scale. Matrix conversion and Vector application
are representation relationships, not constituents of Shear. They live in
swift-matrix-shear and swift-vector-shear. The Matrix initializer
`init(_ shear: Shear<N, Scalar>)` owns conversion; `Shear.matrix` delegates to it.
Both integrations are implemented under an explicit user exception but are not
built or tested in this phase. Their former tests
are preserved in consolidation/DEFERRED-TRANSFORM-INTEGRATION-TESTS.md.

Core native GUI-backed umbrella build and all selected Shear/Rotation tests passed
on My Mac, 2026-09-08 21:23 (12 runtime cases total).
