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
