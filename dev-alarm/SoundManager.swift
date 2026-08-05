//
//  SoundManager.swift
//  dev-alarm
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var audioEngine: AVAudioEngine?
    private var playerNode: AVAudioPlayerNode?
    private var isPlaying = false
    
    private init() {}
    
    func startRinging() {
        guard !isPlaying else { return }
        isPlaying = true
        
        // Configurar la sesión de audio para reproducir sonido incluso en silencio (modo timbre apagado)
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .moviePlayback, options: [.duckOthers])
            try session.setActive(true)
        } catch {
            print("Error al configurar la sesión de audio: \(error)")
        }
        
        let engine = AVAudioEngine()
        let player = AVAudioPlayerNode()
        engine.attach(player)
        
        let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 1)!
        engine.connect(player, to: engine.mainMixerNode, format: format)
        
        // Generar un sonido de alarma personalizado (dos beeps cortos y silencio, en bucle de 1.5 segundos)
        let sampleRate = Float(format.sampleRate)
        let duration: Float = 1.5
        let numSamples = Int(sampleRate * duration)
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(numSamples))!
        buffer.frameLength = AVAudioFrameCount(numSamples)
        
        guard let channels = buffer.floatChannelData else {
            isPlaying = false
            return
        }
        let channel = channels[0]
        
        let frequency1: Float = 987.77  // Nota B5 (si5)
        let frequency2: Float = 1318.51 // Nota E6 (mi6)
        
        for i in 0..<numSamples {
            let time = Float(i) / sampleRate
            
            // Beep 1: 0.0s a 0.15s (987Hz)
            // Beep 2: 0.25s a 0.40s (1318Hz)
            if time >= 0.0 && time < 0.15 {
                channel[i] = sin(2.0 * Float.pi * frequency1 * time) * 0.4
            } else if time >= 0.25 && time < 0.40 {
                channel[i] = sin(2.0 * Float.pi * frequency2 * (time - 0.25)) * 0.4
            } else {
                channel[i] = 0.0
            }
        }
        
        do {
            try engine.start()
            player.play()
            player.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            
            self.audioEngine = engine
            self.playerNode = player
        } catch {
            print("Error al iniciar el motor de audio: \(error)")
            isPlaying = false
        }
    }
    
    func stopRinging() {
        guard isPlaying else { return }
        isPlaying = false
        
        playerNode?.stop()
        audioEngine?.stop()
        
        audioEngine = nil
        playerNode = nil
        
        // Desactivar sesión de audio
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("Error al desactivar la sesión de audio: \(error)")
        }
    }
}
