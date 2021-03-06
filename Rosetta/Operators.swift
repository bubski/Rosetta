import Foundation

//MARK: Main operators

precedencegroup AssignmentPrecedense {
	associativity: left
}

precedencegroup BridgingPrecedence {
	associativity: left
	higherThan: AssignmentPrecedense
}

precedencegroup ValidationPrecedense {
	associativity: left
	higherThan: BridgingPrecedence
}

infix operator <- : AssignmentPrecedense

infix operator <~ : AssignmentPrecedense

infix operator § : BridgingPrecedence

infix operator ~ : BridgingPrecedence

//MARK:-

public func <-<T, U>(left: inout T, right: (Rosetta, Bridge<T, U>, ((T) -> Bool)?)) {
	switch right.0.currentMode! {
	case .encode:
		encodeFrom(left, rosetta: right.0, bridge: right.1, validator: right.2, optional: false);
	case .decode:
		decodeTo(&left, value: right.0.currentValue, rosetta: right.0, bridge: right.1, validator: right.2, optional: false)
	}
}

public func <-<T, U>(left: inout T!, right: (Rosetta, Bridge<T, U>, ((T) -> Bool)?)) {
	switch right.0.currentMode! {
	case .encode:
		encodeFrom(left, rosetta: right.0, bridge: right.1, validator: right.2, optional: false);
	case .decode:
		decodeTo(&left, value: right.0.currentValue, rosetta: right.0, bridge: right.1, validator: right.2, optional: false)
	}
}

public func <-<T, U>(left: inout T?, right: (Rosetta, Bridge<T, U>, ((T) -> Bool)?)) {
	switch right.0.currentMode! {
	case .encode:
		encodeFrom(left, rosetta: right.0, bridge: right.1, validator: right.2, optional: false);
	case .decode:
		decodeTo(&left, value: right.0.currentValue, rosetta: right.0, bridge: right.1, validator: right.2, optional: false)
	}
}

public func <~<T, U>(left: inout T?, right: (Rosetta, Bridge<T, U>, ((T) -> Bool)?)) {
	switch right.0.currentMode! {
	case .encode:
		encodeFrom(left, rosetta: right.0, bridge: right.1, validator: right.2, optional: true);
	case .decode:
		decodeTo(&left, value: right.0.currentValue, rosetta: right.0, bridge: right.1, validator: right.2, optional: true)
	}
}

//MARK: Implicitly omitted validation

public func <-<T, U>(left: inout T, right: (Rosetta, Bridge<T, U>)) {
	left <- (right.0, right.1, nil)
}

public func <-<T, U>(left: inout T!, right: (Rosetta, Bridge<T, U>)) {
	left <- (right.0, right.1, nil)
}

public func <-<T, U>(left: inout T?, right: (Rosetta, Bridge<T, U>)) {
	left <- (right.0, right.1, nil)
}

public func <~<T, U>(left: inout T?, right: (Rosetta, Bridge<T, U>)) {
	left <~ (right.0, right.1, nil)
}

//MARK: Implicit Bridge for Bridgeable types

public func <-<T: Bridgeable>(left: inout T, right: Rosetta) {
	left <- right ~ T.bridge()
}

public func <-<T: Bridgeable>(left: inout T!, right: Rosetta) {
	left <- right ~ T.bridge()
}

public func <-<T: Bridgeable>(left: inout T?, right: Rosetta) {
	left <- right ~ T.bridge()
}

public func <~<T: Bridgeable>(left: inout T?, right: Rosetta) {
	left <~ right ~ T.bridge()
}

// ------------------------------------------------

public func <-<T: Bridgeable>(left: inout [T], right: Rosetta) {
	left <- right ~ BridgeArray(T.bridge())
}

public func <-<T: Bridgeable>(left: inout [T]!, right: Rosetta) {
	left <- right ~ BridgeArray(T.bridge())
}

public func <-<T: Bridgeable>(left: inout [T]?, right: Rosetta) {
	left <- right ~ BridgeArray(T.bridge())
}

public func <~<T: Bridgeable>(left: inout [T]?, right: Rosetta) {
	left <~ right ~ BridgeArray(T.bridge())
}

// ------------------------------------------------

public func <-<T: JSONConvertible>(left: inout [T], right: Rosetta) {
	left <- right ~ BridgeArray(JSONConvertibleBridge())
}

public func <-<T: JSONConvertible>(left: inout [T]!, right: Rosetta) {
	left <- right ~ BridgeArray(JSONConvertibleBridge())
}

public func <-<T: JSONConvertible>(left: inout [T]?, right: Rosetta) {
	left <- right ~ BridgeArray(JSONConvertibleBridge())
}

public func <~<T: JSONConvertible>(left: inout [T]?, right: Rosetta) {
	left <~ right ~ BridgeArray(JSONConvertibleBridge())
}

// ------------------------------------------------

public func <-<T: JSONConvertibleClass>(left: inout [T], right: Rosetta) {
	left <- right ~ BridgeArray(JSONConvertibleClassBridge())
}

public func <-<T: JSONConvertibleClass>(left: inout [T]!, right: Rosetta) {
	left <- right ~ BridgeArray(JSONConvertibleClassBridge())
}

public func <-<T: JSONConvertibleClass>(left: inout [T]?, right: Rosetta) {
	left <- right ~ BridgeArray(JSONConvertibleClassBridge())
}

public func <~<T: JSONConvertibleClass>(left: inout [T]?, right: Rosetta) {
	left <~ right ~ BridgeArray(JSONConvertibleClassBridge())
}

// ------------------------------------------------

public func <-<T: Bridgeable>(left: inout [String: T], right: Rosetta) {
	left <- right ~ BridgeObject(T.bridge())
}

public func <-<T: Bridgeable>(left: inout [String: T]!, right: Rosetta) {
	left <- right ~ BridgeObject(T.bridge())
}

public func <-<T: Bridgeable>(left: inout [String: T]?, right: Rosetta) {
	left <- right ~ BridgeObject(T.bridge())
}

public func <~<T: Bridgeable>(left: inout [String: T]?, right: Rosetta) {
	left <~ right ~ BridgeObject(T.bridge())
}

// ------------------------------------------------

public func <-<T: JSONConvertible>(left: inout [String: T], right: Rosetta) {
	left <- right ~ BridgeObject(JSONConvertibleBridge())
}

public func <-<T: JSONConvertible>(left: inout [String: T]!, right: Rosetta) {
	left <- right ~ BridgeObject(JSONConvertibleBridge())
}

public func <-<T: JSONConvertible>(left: inout [String: T]?, right: Rosetta) {
	left <- right ~ BridgeObject(JSONConvertibleBridge())
}

public func <~<T: JSONConvertible>(left: inout [String: T]?, right: Rosetta) {
	left <~ right ~ BridgeObject(JSONConvertibleBridge())
}

// ------------------------------------------------

public func <-<T: JSONConvertibleClass>(left: inout [String: T], right: Rosetta) {
	left <- right ~ BridgeObject(JSONConvertibleClassBridge())
}

public func <-<T: JSONConvertibleClass>(left: inout [String: T]!, right: Rosetta) {
	left <- right ~ BridgeObject(JSONConvertibleClassBridge())
}

public func <-<T: JSONConvertibleClass>(left: inout [String: T]?, right: Rosetta) {
	left <- right ~ BridgeObject(JSONConvertibleClassBridge())
}

public func <~<T: JSONConvertibleClass>(left: inout [String: T]?, right: Rosetta) {
	left <~ right ~ BridgeObject(JSONConvertibleClassBridge())
}

// ------------------------------------------------

public func <-<T: Bridgeable>(left: inout T, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, T.bridge(), right.1)
}

public func <-<T: Bridgeable>(left: inout T!, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, T.bridge(), right.1)
}

public func <-<T: Bridgeable>(left: inout T?, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, T.bridge(), right.1)
}

public func <~<T: Bridgeable>(left: inout T?, right: (Rosetta, ((T) -> Bool)?)) {
	left <~ (right.0, T.bridge(), right.1)
}

// ------------------------------------------------

public func <-<T: JSONConvertible>(left: inout T, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, JSONConvertibleBridge(), right.1)
}

public func <-<T: JSONConvertible>(left: inout T!, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, JSONConvertibleBridge(), right.1)
}

public func <-<T: JSONConvertible>(left: inout T?, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, JSONConvertibleBridge(), right.1)
}

public func <~<T: JSONConvertible>(left: inout T?, right: (Rosetta, ((T) -> Bool)?)) {
	left <~ (right.0, JSONConvertibleBridge(), right.1)
}

// ------------------------------------------------

public func <-<T: JSONConvertibleClass>(left: inout T, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, JSONConvertibleClassBridge(), right.1)
}

public func <-<T: JSONConvertibleClass>(left: inout T!, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, JSONConvertibleClassBridge(), right.1)
}

public func <-<T: JSONConvertibleClass>(left: inout T?, right: (Rosetta, ((T) -> Bool)?)) {
	left <- (right.0, JSONConvertibleClassBridge(), right.1)
}

public func <~<T: JSONConvertibleClass>(left: inout T?, right: (Rosetta, ((T) -> Bool)?)) {
	left <~ (right.0, JSONConvertibleClassBridge(), right.1)
}

//MARK: Implicit Bridge for JSONConvertible types

public func <-<T: JSONConvertible>(left: inout T, right: Rosetta) {
	left <- right ~ JSONConvertibleBridge()
}

public func <-<T: JSONConvertible>(left: inout T!, right: Rosetta) {
	left <- right ~ JSONConvertibleBridge()
}

public func <-<T: JSONConvertible>(left: inout T?, right: Rosetta) {
	left <- right ~ JSONConvertibleBridge()
}

public func <~<T: JSONConvertible>(left: inout T?, right: Rosetta) {
	left <~ right ~ JSONConvertibleBridge()
}

//MARK: Implicit Bridge for JSONConvertibleClass types

public func <-<T: JSONConvertibleClass>(left: inout T, right: Rosetta) {
	left <- right ~ JSONConvertibleClassBridge()
}

public func <-<T: JSONConvertibleClass>(left: inout T!, right: Rosetta) {
	left <- right ~ JSONConvertibleClassBridge()
}

public func <-<T: JSONConvertibleClass>(left: inout T?, right: Rosetta) {
	left <- right ~ JSONConvertibleClassBridge()
}

public func <~<T: JSONConvertibleClass>(left: inout T?, right: Rosetta) {
	left <~ right ~ JSONConvertibleClassBridge()
}

//MARK: Bridging operator

public func ~<T, U>(left: Rosetta, right: Bridge<T, U>) -> (Rosetta, Bridge<T, U>) {
	return (left, right)
}

//MARK: Validation operator

public func §<T, U>(lhs: (Rosetta, Bridge<T, U>), rhs: ((T) -> Bool)?) -> (Rosetta, Bridge<T, U>, ((T) -> Bool)?) {
	return (lhs.0, lhs.1, rhs)
}

public func §<T>(left: Rosetta, right: ((T) -> Bool)?) -> (Rosetta, ((T) -> Bool)?) {
	return (left, right)
}
