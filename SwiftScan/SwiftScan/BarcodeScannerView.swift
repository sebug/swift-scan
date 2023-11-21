//
//  BarcodeScannerView.swift
//  SwiftScan
//
//  Created by Sebastian Gfeller on 21.11.2023.
//

import SwiftUI
import AVFoundation

struct BarcodeScannerView: View {
    @State private var captureSession : AVCaptureSession?
    @State private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var body: some View {
        ZStack {
            VideoCaptureView(captureSession: $captureSession,
                             videoPreviewLayer: $videoPreviewLayer)
                .edgesIgnoringSafeArea(.all)
            BarcodeOverlay(captureSession: $captureSession)
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear(perform: startSession)
    }
    
    private func startSession() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            
            let metadataOutput = AVCaptureMetadataOutput()
            if (captureSession!.canAddOutput(metadataOutput)) {
                captureSession?.addOutput(metadataOutput)
                metadataOutput.metadataObjectTypes = [.qr]
            }
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = UIScreen.main.bounds
            captureSession?.startRunning()
        } catch {
            print(error)
        }
    }
}

#Preview {
    BarcodeScannerView()
}
