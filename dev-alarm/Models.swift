//
//  Models.swift
//  dev-alarm
//

import Foundation

// MARK: - LOCALIZATION UTILITY
struct Localized {
    static var isSpanish: Bool {
        let lang = Locale.preferredLanguages.first?.lowercased() ?? "en"
        return lang.hasPrefix("es")
    }
    
    static func tr(en: String, es: String) -> String {
        return isSpanish ? es : en
    }
}

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
            return Localized.tr(en: "Once", es: "Una vez")
        }
        if repeatDays.count == 7 {
            return Localized.tr(en: "Every day", es: "Todos los días")
        }
        if repeatDays == Set([2, 3, 4, 5, 6]) {
            return Localized.tr(en: "Weekdays", es: "Lunes a Viernes")
        }
        if repeatDays == Set([1, 7]) {
            return Localized.tr(en: "Weekends", es: "Fines de semana")
        }
        
        let weekdayNamesEn = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let weekdayNamesEs = ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"]
        let sortedDays = repeatDays.sorted()
        return sortedDays.map { Localized.isSpanish ? weekdayNamesEs[$0 - 1] : weekdayNamesEn[$0 - 1] }.joined(separator: ", ")
    }
}

struct Exercise: Identifiable, Codable, Hashable {
    var id: UUID
    var language: ProgrammingLanguage
    var titleEn: String
    var titleEs: String
    var questionEn: String
    var questionEs: String
    var codeSnippet: String
    var optionsEn: [String]
    var optionsEs: [String]
    var correctOptionIndex: Int
    var hintEn: String
    var hintEs: String
    var explanationEn: String
    var explanationEs: String
    
    init(id: UUID = UUID(), language: ProgrammingLanguage, titleEn: String, titleEs: String, questionEn: String, questionEs: String, codeSnippet: String, optionsEn: [String], optionsEs: [String], correctOptionIndex: Int, hintEn: String, hintEs: String, explanationEn: String, explanationEs: String) {
        self.id = id
        self.language = language
        self.titleEn = titleEn
        self.titleEs = titleEs
        self.questionEn = questionEn
        self.questionEs = questionEs
        self.codeSnippet = codeSnippet
        self.optionsEn = optionsEn
        self.optionsEs = optionsEs
        self.correctOptionIndex = correctOptionIndex
        self.hintEn = hintEn
        self.hintEs = hintEs
        self.explanationEn = explanationEn
        self.explanationEs = explanationEs
    }
    
    var title: String { Localized.tr(en: titleEn, es: titleEs) }
    var question: String { Localized.tr(en: questionEn, es: questionEs) }
    var options: [String] { Localized.isSpanish ? optionsEs : optionsEn }
    var hint: String { Localized.tr(en: hintEn, es: hintEs) }
    var explanation: String { Localized.tr(en: explanationEn, es: explanationEs) }
}
