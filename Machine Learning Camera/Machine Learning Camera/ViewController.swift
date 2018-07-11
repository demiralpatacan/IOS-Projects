//
//  ViewController.swift
//  Machine Learning Camera
//
//  Created by Atacan on 11.07.2018.
//  Copyright © 2018 Atacan Demiralp. All rights reserved.
//

import UIKit
import AVKit  //Framework for playing video content
import Vision  //Framework for computer vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet var outputLabel: UILabel!
    
//    @IBAction func circleButton(_ sender: UIButton) {
//        let customLab = CustomLabel()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo   //specifies quality for HQ photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice)
            else {
            return
        }
        
        captureSession.addInput(captureDeviceInput)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "cameraQueue"))
        captureSession.addOutput(dataOutput)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            else {return}
        guard let model = try? VNCoreMLModel(for: Resnet50().model)
            else {return}
        let request = VNCoreMLRequest(model: model) {
            (finishedReq, error) in
            guard let results = finishedReq.results as?
                [VNClassificationObservation] else {return}
            guard let firstObservation = results.first else {return}
            print(firstObservation.identifier, firstObservation.confidence)
            if firstObservation.confidence > 0.6 {
                DispatchQueue.main.async{
                    self.outputLabel.text = "\(firstObservation.identifier), \(firstObservation.confidence)"
                    }
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }


}

