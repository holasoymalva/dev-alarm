//
//  ContentView.swift
//  dev-alarm
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var manager = AlarmManager()
    @State private var showingAddSheet = false
    @State private var alarmToEdit: Alarm? = nil
    @State private var currentTime = Date()
    
    // Timer para actualizar la hora del reloj en tiempo real
    let clockTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack {
                // FONDO
                Color.dracBackground.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // RELOJ DIGITAL PRINCIPAL (Estilo Minimalista Hacker)
                    VStack(spacing: 6) {
                        Text("import Awake;")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.dracComment)
                            .padding(.top, 10)
                        
                        Text(formattedTime(currentTime))
                            .font(.system(size: 54, weight: .bold, design: .monospaced))
                            .foregroundColor(.dracForeground)
                            .shadow(color: Color.dracPurple.opacity(0.3), radius: 10, x: 0, y: 0)
                            .onReceive(clockTimer) { input in
                                currentTime = input
                            }
                        
                        Text(formattedDate(currentTime))
                            .font(.system(.footnote, design: .monospaced))
                            .foregroundColor(.dracComment)
                    }
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity)
                    .background(Color.dracCurrentLine.opacity(0.3))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // SECCIÓN DE ALARMAS
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("alarmas.config")
                                .font(.system(.footnote, design: .monospaced))
                                .foregroundColor(.dracComment)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            // Botón Agregar Alarma
                            Button(action: {
                                showingAddSheet = true
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus")
                                    Text(Localized.tr(en: "new", es: "nueva"))
                                }
                                .font(.system(.caption, design: .monospaced))
                                .fontWeight(.bold)
                                .foregroundColor(.dracBackground)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.dracPurple)
                                .cornerRadius(8)
                            }
                            .buttonStyle(FlatButtonStyle())
                        }
                        .padding(.horizontal)
                        
                        if manager.alarms.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "bell.slash.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.dracComment.opacity(0.5))
                                Text(Localized.tr(en: "No alarms configured", es: "No hay alarmas configuradas"))
                                    .font(.system(.footnote, design: .monospaced))
                                    .foregroundColor(.dracComment)
                            }
                            .frame(maxWidth: .infinity, minHeight: 180)
                            .background(Color.dracCurrentLine.opacity(0.2))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        } else {
                            List {
                                ForEach(manager.alarms) { alarm in
                                    AlarmCard(alarm: alarm, onToggle: { isEnabled in
                                        if let index = manager.alarms.firstIndex(where: { $0.id == alarm.id }) {
                                            manager.alarms[index].isEnabled = isEnabled
                                        }
                                    }, onTap: {
                                        alarmToEdit = alarm
                                    })
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                                    .listRowSeparator(.hidden)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            if let index = manager.alarms.firstIndex(where: { $0.id == alarm.id }) {
                                                manager.alarms.remove(at: index)
                                            }
                                        } label: {
                                            Label(Localized.tr(en: "Delete", es: "Eliminar"), systemImage: "trash.fill")
                                        }
                                        .tint(.dracRed)
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .scrollContentBackground(.hidden)
                            .background(Color.dracBackground)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            // PRESENTACIÓN DE CREAR ALARMA
            .sheet(isPresented: $showingAddSheet) {
                AddEditAlarmView(manager: manager)
            }
            // PRESENTACIÓN DE EDITAR ALARMA
            .sheet(item: $alarmToEdit) { alarm in
                AddEditAlarmView(manager: manager, alarmToEdit: alarm)
            }
            // PRESENTACIÓN DE ALARMA PENDIENTE (PANTALLA DE RESOLUCIÓN)
            .fullScreenCover(item: $manager.activeAlarm) { alarm in
                AlarmTriggerView(manager: manager)
            }
        }
    }
    
    // MARK: - Formatters
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "EEEE, d 'de' MMMM"
        return formatter.string(from: date).capitalized
    }
    
    private func colorForLanguage(_ lang: ProgrammingLanguage) -> Color {
        switch lang {
        case .java: return .dracOrange
        case .javascript: return .dracYellow
        case .python: return .dracCyan
        }
    }
}

// MARK: - TARJETA DE ALARMA INDIVIDUAL
struct AlarmCard: View {
    let alarm: Alarm
    var onToggle: (Bool) -> Void
    var onTap: () -> Void
    
    var body: some View {
        HStack {
            // Información horaria y repetición
            VStack(alignment: .leading, spacing: 6) {
                Text(formattedTime(alarm.time))
                    .font(.system(size: 32, weight: .semibold, design: .monospaced))
                    .foregroundColor(alarm.isEnabled ? .dracForeground : .dracComment)
                
                HStack(spacing: 8) {
                    // Tag de Lenguaje
                    HStack(spacing: 4) {
                        Image(systemName: alarm.language.iconName)
                            .font(.caption2)
                        Text(alarm.language.rawValue)
                    }
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.dracBackground)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(colorForLanguage(alarm.language))
                    .cornerRadius(4)
                    
                    // Texto de repetición
                    Text(alarm.repeatDescription)
                        .font(.system(.caption2, design: .monospaced))
                        .foregroundColor(.dracComment)
                }
            }
            
            Spacer()
            
            // Interruptor Habilitar/Deshabilitar Alarma
            Toggle("", isOn: Binding(
                get: { alarm.isEnabled },
                set: { onToggle($0) }
            ))
            .toggleStyle(SwitchToggleStyle(tint: .dracPurple))
            .labelsHidden()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.dracCurrentLine.opacity(0.4))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(alarm.isEnabled ? Color.dracPurple.opacity(0.2) : Color.clear, lineWidth: 1)
        )
        // Detectar toque para edición
        .onTapGesture {
            onTap()
        }
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func colorForLanguage(_ lang: ProgrammingLanguage) -> Color {
        switch lang {
        case .java: return .dracOrange
        case .javascript: return .dracYellow
        case .python: return .dracCyan
        }
    }
}

// MARK: - PREVIEWPROVIDER CLASSIC
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
