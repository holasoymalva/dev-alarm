//
//  Models.swift
//  dev-alarm
//

import Foundation

enum ProgrammingLanguage: String, Codable, CaseIterable, Identifiable {
    case java = "Java"
    case javascript = "JavaScript"
    case python = "Python"
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .java: return "cup.and.saucer.fill"
        case .javascript: return "script.badge.ellipsis"
        case .python: return "chevron.left.forwardslash.chevron.right"
        }
    }
}

struct Alarm: Identifiable, Codable, Hashable {
    var id: UUID
    var time: Date
    var isEnabled: Bool
    var repeatDays: Set<Int> // 1 = Sunday, 2 = Monday, etc. (Calendar.current.component(.weekday, from: date))
    var language: ProgrammingLanguage
    var snoozeCount: Int
    
    init(id: UUID = UUID(), time: Date, isEnabled: Bool = true, repeatDays: Set<Int> = [], language: ProgrammingLanguage = .javascript, snoozeCount: Int = 0) {
        self.id = id
        self.time = time
        self.isEnabled = isEnabled
        self.repeatDays = repeatDays
        self.language = language
        self.snoozeCount = snoozeCount
    }
    
    var repeatDescription: String {
        if repeatDays.isEmpty {
            return "Una vez"
        }
        if repeatDays.count == 7 {
            return "Todos los días"
        }
        if repeatDays == Set([2, 3, 4, 5, 6]) {
            return "Lunes a Viernes"
        }
        if repeatDays == Set([1, 7]) {
            return "Fines de semana"
        }
        
        let weekdayNames = ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"]
        let sortedDays = repeatDays.sorted()
        return sortedDays.map { weekdayNames[$0 - 1] }.joined(separator: ", ")
    }
}

struct Exercise: Identifiable, Codable, Hashable {
    var id: UUID
    var language: ProgrammingLanguage
    var title: String
    var question: String
    var codeSnippet: String
    var options: [String]
    var correctOptionIndex: Int
    var hint: String
    var explanation: String
    
    init(id: UUID = UUID(), language: ProgrammingLanguage, title: String, question: String, codeSnippet: String, options: [String], correctOptionIndex: Int, hint: String, explanation: String) {
        self.id = id
        self.language = language
        self.title = title
        self.question = question
        self.codeSnippet = codeSnippet
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self.hint = hint
        self.explanation = explanation
    }
}
