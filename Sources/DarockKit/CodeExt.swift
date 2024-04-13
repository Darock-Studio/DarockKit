//
//  CodeExt.swift
//  DarockKit
//
//  Created by WindowsMEMZ on 2023/6/29.
//

import Foundation
import SwiftUI

extension String {
    public func apiFixed(_ fixType: ApiFixType = .server) -> String {
        if fixType == .server {
            return String(String(self.dropFirst()).dropLast())
        } else {
            return "\"\(self)\""
        }
    }
    public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    public func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    public func base64Encoded() -> String {
            return Data(self.utf8).base64EncodedString()
    }
}

extension Color {
    public init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}

public enum ApiFixType {
    case client
    case server
}

#if canImport(CoreHaptics)
import CoreHaptics

var globalHapticEngine: CHHapticEngine?

public func PlayHaptic(sharpness: Float, intensity: Float) {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    events.append(event)
    do {
        let pattern = try CHHapticPattern(events: events, parameters: [])
        let player = try globalHapticEngine?.makePlayer(with: pattern)
        try player?.start(atTime: 0)
    } catch {
        print("Failed to play pattern: \(error.localizedDescription).")
    }
}
#endif

postfix operator ++
postfix operator --
prefix operator ++
prefix operator --
public extension Int {
    @discardableResult
    static postfix func ++ (num: inout Int) -> Int {
        num += 1
        return num - 1
    }
    
    @discardableResult
    static postfix func -- (num: inout Int) -> Int {
        num -= 1
        return num + 1
    }
    
    @discardableResult
    static prefix func ++ (num: inout Int) -> Int {
        num += 1
        return num
    }
    
    @discardableResult
    static prefix func -- (num: inout Int) -> Int {
        num -= 1
        return num
    }
}

public extension Bool {
    @_transparent
    init(_ input: Int) {
        if input == 0 {
            self = false
        } else {
            self = true
        }
    }
}
public extension Int {
    @_transparent
    init (_ input: Bool) {
        if input {
            self = 1
        } else {
            self = 0
        }
    }
}

infix operator ~
public extension Float {
    static func ~ (lhs: Float, rhs: Int) -> String {
        return String(format: "%.\(rhs)f", lhs)
    }
}
public extension Double {
    static func ~ (lhs: Double, rhs: Int) -> String {
        return String(format: "%.\(rhs)f", lhs)
    }
}

prefix operator &&
public prefix func && <T>(input: inout T) -> UnsafeMutablePointer<T> {
    withUnsafeMutablePointer(to: &input) { $0 }
}
prefix operator *
public prefix func * <T>(ptr: UnsafeMutablePointer<T>) -> T {
    return ptr.pointee
}
