# swift-shear

Use this package when you need to name, store, compare, invert or serialise an elementary shear of N-dimensional space: one target axis displaced along by a factor times one other source axis. Start from `Shear`. It is only the validated description: to apply a shear to coordinates, use the Shear integration in swift-vector, and to get its matrix, use the one in swift-matrix.

## Laws

- Every `Shear` value is valid. Both axes lie in `0..<N`, they are distinct, and the factor is finite. The initialiser checks axis range first, then whether the axes coincide, then the factor.
- A zero factor is stored as positive zero, so a shear built with `-0.0` equals and hashes the same as one built with `0.0`. A zero-factor shear is still a shear of its two axes, and it is its own `inverse`.
- `inverse` keeps `target` and `source` and negates the factor. `inverse.inverse` equals the original.
- Coding uses a flat keyed form, `target`, `source` and `factor`, with each axis written as its integer index. Decoding runs the same validation, and an invalid shear fails as corrupted data.
