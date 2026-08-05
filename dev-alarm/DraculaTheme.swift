//
//  DraculaTheme.swift
//  dev-alarm
//

import SwiftUI

extension Color {
    static let dracBackground = Color(hex: "282a36")
    static let dracCurrentLine = Color(hex: "44475a")
    static let dracForeground = Color(hex: "f8f8f2")
    static let dracComment = Color(hex: "6272a4")
    static let dracCyan = Color(hex: "8be9fd")
    static let dracGreen = Color(hex: "50fa7b")
    static let dracOrange = Color(hex: "ffb86c")
    static let dracPink = Color(hex: "ff79c6")
    static let dracPurple = Color(hex: "bd93f9")
    static let dracRed = Color(hex: "ff5555")
    static let dracYellow = Color(hex: "f1fa8c")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
