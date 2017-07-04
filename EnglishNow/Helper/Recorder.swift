//
//  Recorder.swift
//  EnglishNow
//
//  Created by GeniusDoan on 7/4/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import AVFoundation

class Recorder {
    static var shared = Recorder()
    var documentsDirectory: URL
    //    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    
    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        documentsDirectory = paths[0]
    }
    
    func start(nameFile: String) {
        let audioFilename = documentsDirectory.appendingPathComponent("\(nameFile).m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        print("file: \(audioFilename.absoluteString)")
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            //            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            //            finishRecording(success: false)
            print("record start fail")
        }
    }
    
    func stop() {
        if audioRecorder != nil {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }
    
    func play(nameFile: String) {
        let audioFilename = documentsDirectory.appendingPathComponent("\(nameFile).m4a")
        do {
            player = try AVAudioPlayer(contentsOf: audioFilename)
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        if player != nil {
            player.stop()
            player = nil
        }
    }
}
