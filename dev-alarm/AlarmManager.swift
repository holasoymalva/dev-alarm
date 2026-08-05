//
//  AlarmManager.swift
//  dev-alarm
//

import Foundation
import UserNotifications
import Combine

class AlarmManager: ObservableObject {
    @Published var alarms: [Alarm] = [] {
        didSet {
            saveAlarms()
            scheduleNotifications()
        }
    }
    
    @Published var activeAlarm: Alarm? = nil
    @Published var activeExercise: Exercise? = nil
    
    private var timer: Timer?
    private var lastFiredTime: Date?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadAlarms()
        requestNotificationPermission()
        startCheckTimer()
        
        // Registrar observador para cuando la app vuelve al primer plano
        NotificationCenter.default.publisher(for: Notification.Name("UIApplicationDidBecomeActiveNotification"))
            .sink { [weak self] _ in
                self?.checkOnForeground()
            }
            .store(in: &cancellables)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Persistence
    private func saveAlarms() {
        if let encoded = try? JSONEncoder().encode(alarms) {
            UserDefaults.standard.set(encoded, forKey: "saved_alarms")
        }
    }
    
    private func loadAlarms() {
        if let data = UserDefaults.standard.data(forKey: "saved_alarms"),
           let decoded = try? JSONDecoder().decode([Alarm].self, from: data) {
            self.alarms = decoded
        } else {
            // Valores por defecto para una experiencia rica desde el inicio
            let calendar = Calendar.current
            var comp1 = DateComponents()
            comp1.hour = 7
            comp1.minute = 0
            let date1 = calendar.date(from: comp1) ?? Date()
            
            var comp2 = DateComponents()
            comp2.hour = 8
            comp2.minute = 30
            let date2 = calendar.date(from: comp2) ?? Date()
            
            self.alarms = [
                Alarm(time: date1, isEnabled: true, repeatDays: Set([2,3,4,5,6]), language: .javascript),
                Alarm(time: date2, isEnabled: false, repeatDays: Set([1,7]), language: .python)
            ]
            saveAlarms()
        }
    }
    
    // MARK: - Notifications
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permiso de notificaciones concedido")
            } else if let error = error {
                print("Error de permisos de notificación: \(error)")
            }
        }
    }
    
    private func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        for alarm in alarms {
            if alarm.isEnabled {
                let content = UNMutableNotificationContent()
                content.title = "⏰ ¡Hora de programar!"
                content.body = "La alarma está sonando. Resuelve el acertijo en \(alarm.language.rawValue) para apagarla."
                content.sound = UNNotificationSound.default
                
                if alarm.repeatDays.isEmpty {
                    // Alarma de una sola vez
                    let triggerDate = nextTriggerDate(for: alarm)
                    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                    let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
                    center.add(request) { error in
                        if let error = error {
                            print("Error al programar alarma única: \(error)")
                        }
                    }
                } else {
                    // Alarma repetitiva
                    for day in alarm.repeatDays {
                        var components = DateComponents()
                        components.hour = Calendar.current.component(.hour, from: alarm.time)
                        components.minute = Calendar.current.component(.minute, from: alarm.time)
                        components.weekday = day
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                        let identifier = "\(alarm.id.uuidString)_\(day)"
                        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                        center.add(request) { error in
                            if let error = error {
                                print("Error al programar alarma repetitiva: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Logic Calculations
    func nextTriggerDate(for alarm: Alarm, relativeTo date: Date = Date()) -> Date {
        let calendar = Calendar.current
        let now = date
        
        let alarmHour = calendar.component(.hour, from: alarm.time)
        let alarmMinute = calendar.component(.minute, from: alarm.time)
        
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = alarmHour
        components.minute = alarmMinute
        components.second = 0
        
        guard let todayAlarmTime = calendar.date(from: components) else { return now }
        
        if alarm.repeatDays.isEmpty {
            if todayAlarmTime >= now {
                return todayAlarmTime
            } else {
                return calendar.date(byAdding: .day, value: 1, to: todayAlarmTime) ?? todayAlarmTime
            }
        } else {
            for offset in 0..<7 {
                if let candidateDate = calendar.date(byAdding: .day, value: offset, to: todayAlarmTime) {
                    let candidateWeekday = calendar.component(.weekday, from: candidateDate)
                    if alarm.repeatDays.contains(candidateWeekday) {
                        if offset > 0 || candidateDate >= now {
                            return candidateDate
                        }
                    }
                }
            }
            return todayAlarmTime
        }
    }
    
    // MARK: - Trigger Management
    private func startCheckTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkAlarms()
        }
    }
    
    private func checkAlarms() {
        guard activeAlarm == nil else { return }
        
        let now = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: now)
        let currentMinute = calendar.component(.minute, from: now)
        let currentWeekday = calendar.component(.weekday, from: now)
        
        if let lastFired = lastFiredTime,
           calendar.isDate(lastFired, equalTo: now, toGranularity: .minute) {
            return
        }
        
        for alarm in alarms {
            if alarm.isEnabled {
                let alarmHour = calendar.component(.hour, from: alarm.time)
                let alarmMinute = calendar.component(.minute, from: alarm.time)
                
                if alarmHour == currentHour && alarmMinute == currentMinute {
                    if alarm.repeatDays.isEmpty || alarm.repeatDays.contains(currentWeekday) {
                        triggerAlarm(alarm)
                        break
                    }
                }
            }
        }
    }
    
    func checkOnForeground() {
        guard activeAlarm == nil else { return }
        let now = Date()
        
        for alarm in alarms {
            if alarm.isEnabled {
                let fiveMinutesAgo = now.addingTimeInterval(-300)
                let triggerDate = nextTriggerDate(for: alarm, relativeTo: fiveMinutesAgo)
                
                if triggerDate <= now && triggerDate >= fiveMinutesAgo {
                    triggerAlarm(alarm)
                    break
                }
            }
        }
    }
    
    func triggerAlarm(_ alarm: Alarm) {
        lastFiredTime = Date()
        activeAlarm = alarm
        activeExercise = ExerciseBank.randomExercise(for: alarm.language)
        SoundManager.shared.startRinging()
    }
    
    func triggerTestAlarm(with language: ProgrammingLanguage) {
        let testAlarm = Alarm(
            time: Date(),
            isEnabled: true,
            repeatDays: [],
            language: language,
            snoozeCount: 0
        )
        triggerAlarm(testAlarm)
    }
    
    func dismissActiveAlarm() {
        SoundManager.shared.stopRinging()
        if let alarm = activeAlarm {
            if alarm.repeatDays.isEmpty {
                if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
                    alarms[index].isEnabled = false
                }
            }
        }
        activeAlarm = nil
        activeExercise = nil
    }
    
    func snoozeActiveAlarm() {
        SoundManager.shared.stopRinging()
        if let alarm = activeAlarm {
            // Crear alarma temporal para dentro de 2 minutos (120 segundos)
            let snoozeTime = Date().addingTimeInterval(120)
            let snoozeAlarm = Alarm(
                time: snoozeTime,
                isEnabled: true,
                repeatDays: [],
                language: alarm.language,
                snoozeCount: alarm.snoozeCount + 1
            )
            alarms.append(snoozeAlarm)
        }
        activeAlarm = nil
        activeExercise = nil
    }
}
