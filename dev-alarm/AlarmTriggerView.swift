//
//  AlarmTriggerView.swift
//  dev-alarm
//

import SwiftUI

struct AlarmTriggerView: View {
    @ObservedObject var manager: AlarmManager
    
    @State private var selectedOption: Int? = nil
    @State private var isAnswerCorrect: Bool? = nil
    @State private var showHint = false
    @State private var showExplanation = false
    @State private var shakeOffset: CGFloat = 0
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        if let exercise = manager.activeExercise {
            ZStack {
                // FONDO
                Color.dracBackground.ignoresSafeArea()
                
                // Efecto de pulso en el fondo
                RadialGradient(
                    colors: [Color.dracRed.opacity(0.15 * Double(pulseScale)), Color.clear],
                    center: .center,
                    startRadius: 10,
                    endRadius: 400
                )
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                        pulseScale = 1.3
                    }
                }
                
                VStack(spacing: 20) {
                    // ENCABEZADO DE ALARMA
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: "bell.badge.fill")
                                .foregroundColor(.dracRed)
                                .font(.title)
                                .rotationEffect(.degrees(pulseScale > 1.15 ? 15 : -15))
                                .animation(Animation.linear(duration: 0.15).repeatForever(autoreverses: true), value: pulseScale)
                            
                            Text("ALARMA ACTIVA")
                                .font(.system(.title3, design: .monospaced))
                                .fontWeight(.bold)
                                .foregroundColor(.dracRed)
                        }
                        
                        Text(currentFormattedTime())
                            .font(.system(size: 48, weight: .black, design: .monospaced))
                            .foregroundColor(.dracForeground)
                    }
                    .padding(.top, 40)
                    
                    // PREGUNTA
                    VStack(alignment: .leading, spacing: 8) {
                        Text(exercise.question)
                            .font(.system(.headline, design: .default))
                            .foregroundColor(.dracForeground)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 4)
                    }
                    .padding(.horizontal)
                    
                    // EDITOR DE CÓDIGO (ESTILO VS CODE)
                    VStack(alignment: .leading, spacing: 0) {
                        // Barra superior
                        HStack(spacing: 6) {
                            Circle().fill(Color.dracRed).frame(width: 8, height: 8)
                            Circle().fill(Color.dracYellow).frame(width: 8, height: 8)
                            Circle().fill(Color.dracGreen).frame(width: 8, height: 8)
                            Spacer()
                            Text(exercise.title)
                                .font(.system(size: 10, weight: .medium, design: .monospaced))
                                .foregroundColor(.dracComment)
                            Spacer()
                            Text(exercise.language.rawValue.lowercased() + ".code")
                                .font(.system(size: 10, weight: .medium, design: .monospaced))
                                .foregroundColor(.dracCyan)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.dracCurrentLine)
                        
                        // Editor
                        HStack(alignment: .top) {
                            // Números de línea
                            VStack(alignment: .trailing, spacing: 4) {
                                ForEach(1...lineCount(exercise.codeSnippet), id: \.self) { i in
                                    Text("\\(i)")
                                        .font(.system(.footnote, design: .monospaced))
                                        .foregroundColor(Color.dracComment.opacity(0.6))
                                }
                            }
                            .padding(.vertical)
                            .padding(.leading, 8)
                            
                            Divider()
                                .background(Color.dracComment.opacity(0.3))
                                .padding(.vertical, 8)
                            
                            // Código
                            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                                Text(exercise.codeSnippet)
                                    .font(.system(.footnote, design: .monospaced))
                                    .padding(.vertical)
                                    .foregroundColor(.dracForeground)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .background(Color(hex: "1e1f29"))
                    }
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.dracComment.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .offset(x: shakeOffset)
                    
                    // BOTONES DE OPCIONES
                    VStack(spacing: 10) {
                        ForEach(0..<exercise.options.count, id: \.self) { idx in
                            let optionText = exercise.options[idx]
                            
                            Button(action: {
                                checkAnswer(optionIndex: idx, correctIndex: exercise.correctOptionIndex)
                            }) {
                                HStack {
                                    Text(characterForIndex(idx))
                                        .font(.system(.subheadline, design: .monospaced))
                                        .fontWeight(.bold)
                                        .foregroundColor(selectedOption == idx ? .dracBackground : .dracPink)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(selectedOption == idx ? Color.dracBackground.opacity(0.2) : Color.dracCurrentLine.opacity(0.5))
                                        .cornerRadius(4)
                                    
                                    Text(optionText)
                                        .font(.system(.subheadline, design: .monospaced))
                                        .foregroundColor(selectedOption == idx ? .dracBackground : .dracForeground)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                                .frame(maxWidth: .infinity)
                                .background(backgroundColorForOption(idx, correctIndex: exercise.correctOptionIndex))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(borderColorForOption(idx, correctIndex: exercise.correctOptionIndex), lineWidth: 1)
                                )
                            }
                            .buttonStyle(FlatButtonStyle())
                            .disabled(isAnswerCorrect == true)
                        }
                    }
                    .padding(.horizontal)
                    
                    // SECCIÓN DE PISTAS Y EXPLICACIÓN
                    HStack(spacing: 20) {
                        // Pista
                        Button(action: {
                            withAnimation { showHint.toggle() }
                        }) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                Text("Tip")
                            }
                            .font(.system(.footnote, design: .monospaced))
                            .foregroundColor(.dracYellow)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.dracCurrentLine.opacity(0.5))
                            .cornerRadius(8)
                        }
                        .buttonStyle(FlatButtonStyle())
                        
                        // Explicación
                        Button(action: {
                            showExplanation = true
                        }) {
                            HStack {
                                Image(systemName: "doc.text.magnifyingglass")
                                Text("Solución")
                            }
                            .font(.system(.footnote, design: .monospaced))
                            .foregroundColor(.dracCyan)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.dracCurrentLine.opacity(0.5))
                            .cornerRadius(8)
                        }
                        .buttonStyle(FlatButtonStyle())
                        
                        Spacer()
                        
                        // Snooze
                        Button(action: {
                            manager.snoozeActiveAlarm()
                        }) {
                            Text("Snooze (2m)")
                                .font(.system(.footnote, design: .monospaced))
                                .foregroundColor(.dracComment)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.dracComment.opacity(0.4), lineWidth: 1)
                                )
                        }
                        .buttonStyle(FlatButtonStyle())
                    }
                    .padding(.horizontal)
                    
                    // MOSTRAR HINT SI ESTÁ ACTIVO
                    if showHint {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("💡 SUGERENCIA:")
                                .font(.system(.caption, design: .monospaced))
                                .fontWeight(.bold)
                                .foregroundColor(.dracYellow)
                            Text(exercise.hint)
                                .font(.system(.footnote, design: .default))
                                .foregroundColor(.dracForeground)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.dracCurrentLine.opacity(0.4))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.dracYellow.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .transition(.opacity)
                    }
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $showExplanation) {
                ExplanationView(exercise: exercise, isPresented: $showExplanation)
            }
        }
    }
    
    // MARK: - Helpers
    private func currentFormattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
    
    private func lineCount(_ text: String) -> Int {
        let lines = text.components(separatedBy: "\n")
        return max(1, lines.count)
    }
    
    private func characterForIndex(_ index: Int) -> String {
        let chars = ["A", "B", "C", "D"]
        return index < chars.count ? chars[index] : "\\(index)"
    }
    
    private func checkAnswer(optionIndex: Int, correctIndex: Int) {
        selectedOption = optionIndex
        
        if optionIndex == correctIndex {
            isAnswerCorrect = true
            // Feedback háptico de éxito
            triggerHapticFeedback(success: true)
            
            // Retardo para dismiss para que se vea la animación
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                manager.dismissActiveAlarm()
            }
        } else {
            isAnswerCorrect = false
            triggerHapticFeedback(success: false)
            shake()
        }
    }
    
    private func shake() {
        let animationDuration: TimeInterval = 0.08
        withAnimation(.linear(duration: animationDuration)) {
            shakeOffset = 10
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            withAnimation(.linear(duration: animationDuration)) {
                shakeOffset = -10
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (animationDuration * 2)) {
                withAnimation(.linear(duration: animationDuration)) {
                    shakeOffset = 10
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + (animationDuration * 3)) {
                    withAnimation(.linear(duration: animationDuration)) {
                        shakeOffset = 0
                    }
                }
            }
        }
    }
    
    private func triggerHapticFeedback(success: Bool) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(success ? .success : .error)
    }
    
    // MARK: - Style Helpers
    private func backgroundColorForOption(_ index: Int, correctIndex: Int) -> Color {
        if selectedOption == index {
            if isAnswerCorrect == true {
                return .dracGreen
            } else if isAnswerCorrect == false {
                return .dracRed
            }
        }
        
        // Si el usuario ya falló pero no es la opción seleccionada actualmente
        return Color.dracCurrentLine.opacity(0.3)
    }
    
    private func borderColorForOption(_ index: Int, correctIndex: Int) -> Color {
        if selectedOption == index {
            if isAnswerCorrect == true {
                return .dracGreen
            } else if isAnswerCorrect == false {
                return .dracRed
            }
        }
        return Color.dracComment.opacity(0.2)
    }
}

// MARK: - EXPLANATION SHEET
struct ExplanationView: View {
    let exercise: Exercise
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.dracBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Cabezal
                HStack {
                    Text("Explicación del Ejercicio")
                        .font(.system(.title3, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.dracCyan)
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.dracComment)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Título de la pregunta
                        VStack(alignment: .leading, spacing: 6) {
                            Text("TEMA:")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.dracComment)
                                .fontWeight(.bold)
                            Text(exercise.title)
                                .font(.headline)
                                .foregroundColor(.dracForeground)
                        }
                        
                        Divider().background(Color.dracComment.opacity(0.3))
                        
                        // Respuesta Correcta
                        VStack(alignment: .leading, spacing: 6) {
                            Text("RESPUESTA CORRECTA:")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.dracGreen)
                                .fontWeight(.bold)
                            
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.dracGreen)
                                Text(exercise.options[exercise.correctOptionIndex])
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(.dracForeground)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.dracCurrentLine)
                                    .cornerRadius(6)
                            }
                        }
                        
                        Divider().background(Color.dracComment.opacity(0.3))
                        
                        // Explicación
                        VStack(alignment: .leading, spacing: 8) {
                            Text("¿POR QUÉ?")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.dracPurple)
                                .fontWeight(.bold)
                            
                            Text(exercise.explanation)
                                .font(.body)
                                .foregroundColor(.dracForeground)
                                .lineSpacing(4)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
                
                // Mensaje persuasivo de aprendizaje
                VStack(spacing: 8) {
                    Text("💡 APRENDIZAJE REFORZADO")
                        .font(.system(.caption, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.dracYellow)
                    Text("Para apagar la alarma, debes cerrar esta explicación y seleccionar la respuesta correcta.")
                        .font(.caption)
                        .foregroundColor(.dracForeground)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.dracCurrentLine.opacity(0.5))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
    }
}

// MARK: - PREVIEWS
struct AlarmTriggerView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = AlarmManager()
        // Crear una alarma simulada activa para la vista previa
        let alarm = Alarm(time: Date(), isEnabled: true, language: .javascript)
        let exercise = ExerciseBank.allExercises[0]
        
        // Simular valores activos
        let view = AlarmTriggerView(manager: manager)
        let _ = {
            manager.activeAlarm = alarm
            manager.activeExercise = exercise
        }()
        
        return view
    }
}
