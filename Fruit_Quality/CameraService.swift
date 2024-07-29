//
//  CameraService.swift
//  FruitApp
//
//  Created by Kevin Sun on 7/22/24.
//

import Foundation
import AVFoundation

class CameraService {
    
    var session: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    // Start the camera service and check for permissions
    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping(Error?) -> ()) {
        self.delegate = delegate
        checkPermissions(completion: completion)
    }
    
    // Check camera permissions and set up the camera if authorized
    private func checkPermissions(completion: @escaping(Error?) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else { return }
                DispatchQueue.main.async {
                    self?.setupCamera(completion: completion)
                }
            }
        case .restricted, .denied:
            break
        case .authorized:
            setupCamera(completion: completion)
        @unknown default:
            break
        }
    }
    
    // Set up the camera session with input and output
    private func setupCamera(completion: @escaping(Error?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let session = AVCaptureSession()
            if let device = AVCaptureDevice.default(for: .video) {
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    if session.canAddInput(input) {
                        session.addInput(input)
                    }
                    
                    if session.canAddOutput(self?.output ?? AVCapturePhotoOutput()) {
                        session.addOutput(self?.output ?? AVCapturePhotoOutput())
                    }
                    
                    self?.previewLayer.videoGravity = .resizeAspectFill
                    self?.previewLayer.session = session
                    session.startRunning()
                    DispatchQueue.main.async {
                        self?.session = session
                        completion(nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            }
        }
    }
    
    // Capture a photo with the given settings
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
        output.capturePhoto(with: settings, delegate: delegate!)
    }
    
}
