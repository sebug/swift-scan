//
//  VideoCaptureView.swift
//  SwiftScan
//
//  Created by Sebastian Gfeller on 21.11.2023.
//

import SwiftUI
import AVFoundation

struct VideoCaptureView: UIViewRepresentable {
    @Binding var captureSession: AVCaptureSession?
        @Binding var videoPreviewLayer: AVCaptureVideoPreviewLayer?
        
        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            videoPreviewLayer?.removeFromSuperlayer()
            if let videoPreviewLayer = videoPreviewLayer {
                uiView.layer.addSublayer(videoPreviewLayer)
            }
        }
}


