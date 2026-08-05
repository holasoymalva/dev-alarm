//
//  AddEditAlarmView.swift
//  dev-alarm
//

import SwiftUI

struct AddEditAlarmView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var manager: AlarmManager
    
    var alarmToEdit: Alarm?
    
    @State private var time: Date
    @State private var selectedLanguage: ProgrammingLanguage
    @State private var repeatDays: Set<Int>
    
    let weekdays = [
        (1, "D"), (2, "L"), (3, "M"), (4, "M"), (5, "J"), (6, "V"), (7, "S")
    ]
    
    init(manager: AlarmManager, alarmToEdit: Alarm? = nil) {
        self.manager = manager
        self.alarmToEdit = alarmToEdit
        
        // Inicializar estado con valores existentes o por defecto
        if let alarm = alarmToEdit {
            _time = State(initialValue: alarm.time)
            _selectedLanguage = State(initialValue: alarm.language)
            _repeatDays = State(initialValue: alarm.repeatDays)
        } else {
            // Siguiente hora en punto
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
            components.minute = 0
            if let nextHour = calendar.date(from: components)?.addingTimeInterval(3600) {
                _time = State(initialValue: nextHour)
            } else {
                _time = State(initialValue: Date())
            }
            _selectedLanguage = State(initialValue: .javascript)
            _repeatDays = State(initialValue: [])
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.dracBackground.ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // TÍTULO DE LA ACCIÓN
                    Text(alarmToEdit == nil ? "Nueva Alarma" : "Editar Alarma")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.dracForeground)
                        .padding(.top, 16)
                    
                    // SELECCIÓN DE HORA (Estilo Wheel en fondo oscuro)
                    VStack {
                        DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .accentColor(.dracPurple)
                            .frame(maxWidth: .infinity)
                            .background(Color.dracCurrentLine.opacity(0.3))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // SELECCIÓN DE LENGUAJE (Tarjetas de código)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("LENGUAJE DE EJERCICIO")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.dracComment)
                            .fontWeight(.bold)
                            .padding(.leading, 8)
                        
                        HStack(spacing: 12) {
                            ForEach(ProgrammingLanguage.allCases) { lang in
                                Button(action: {
                                    selectedLanguage = lang
                                }) {
                                    VStack(spacing: 8) {
                                        Image(systemName: lang.iconName)
                                            .font(.title2)
                                            .foregroundColor(selectedLanguage == lang ? .dracBackground : colorForLanguage(lang))
                                        
                                        Text(lang.rawValue)
                                            .font(.system(.footnote, design: .monospaced))
                                            .fontWeight(.bold)
                                            .foregroundColor(selectedLanguage == lang ? .dracBackground : .dracForeground)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.6)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80)
                                    .background(selectedLanguage == lang ? colorForLanguage(lang) : Color.dracCurrentLine)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedLanguage == lang ? Color.clear : Color.dracComment.opacity(0.3), lineWidth: 1)
                                    )
                                    .shadow(color: selectedLanguage == lang ? colorForLanguage(lang).opacity(0.4) : Color.clear, radius: 8, x: 0, y: 4)
                                }
                                .buttonStyle(FlatButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // REPETICIÓN (Días de la semana)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("REPETIR")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.dracComment)
                            .fontWeight(.bold)
                            .padding(.leading, 8)
                        
                        HStack(spacing: 8) {
                            ForEach(weekdays, id: \.0) { dayNum, dayName in
                                let isSelected = repeatDays.contains(dayNum)
                                Button(action: {
                                    if isSelected {
                                        repeatDays.remove(dayNum)
                                    } else {
                                        repeatDays.insert(dayNum)
                                    }
                                }) {
                                    Text(dayName)
                                        .font(.system(.body, design: .monospaced))
                                        .fontWeight(.bold)
                                        .foregroundColor(isSelected ? .dracBackground : .dracForeground)
                                        .frame(width: 40, height: 40)
                                        .background(isSelected ? Color.dracPurple : Color.dracCurrentLine)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(isSelected ? Color.clear : Color.dracComment.opacity(0.3), lineWidth: 1)
                                        )
                                }
                                .buttonStyle(FlatButtonStyle())
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // BOTONES GUARDAR / ELIMINAR / CANCELAR
                    VStack(spacing: 12) {
                        Button(action: saveAlarm) {
                            Text("Guardar")
                                .font(.system(.body, design: .monospaced))
                                .fontWeight(.bold)
                                .foregroundColor(.dracBackground)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.dracGreen)
                                .cornerRadius(12)
                                .shadow(color: Color.dracGreen.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        
                        if let alarm = alarmToEdit {
                            Button(action: {
                                deleteAlarm(alarm)
                            }) {
                                Text("Eliminar Alarma")
                                    .font(.system(.body, design: .monospaced))
                                    .fontWeight(.bold)
                                    .foregroundColor(.dracRed)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(Color.clear)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.dracRed.opacity(0.6), lineWidth: 1.5)
                                    )
                            }
                        }
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancelar")
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.dracComment)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Helpers
    private func colorForLanguage(_ lang: ProgrammingLanguage) -> Color {
        switch lang {
        case .java: return .dracOrange
        case .javascript: return .dracYellow
        case .python: return .dracCyan
        }
    }
    
    private func saveAlarm() {
        if let editing = alarmToEdit {
            if let index = manager.alarms.firstIndex(where: { $0.id == editing.id }) {
                manager.alarms[index] = Alarm(
                    id: editing.id,
                    time: time,
                    isEnabled: true,
                    repeatDays: repeatDays,
                    language: selectedLanguage,
                    snoozeCount: 0
                )
            }
        } else {
            let newAlarm = Alarm(
                id: UUID(),
                time: time,
                isEnabled: true,
                repeatDays: repeatDays,
                language: selectedLanguage,
                snoozeCount: 0
            )
            manager.alarms.append(newAlarm)
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteAlarm(_ alarm: Alarm) {
        manager.alarms.removeAll(where: { $0.id == alarm.id })
        presentationMode.wrappedValue.dismiss()
    }
}

// Estilo de botón sin animaciones nativas de parpadeo molestas
struct FlatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct AddEditAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditAlarmView(manager: AlarmManager())
    }
}
