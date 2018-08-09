//
//  WinTicketsPresenter.swift
//  Festival-App
//
//  Created by Octavian Duminica on 09/08/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation
import CoreML
import Vision

class WinTicketsPresenter {
    weak var view: WinTicketsView?
    
    init(view: WinTicketsView) {
        self.view = view
    }
    
    func beginRecognitionProcess(forData data: Data) {
        guard let model = try? VNCoreMLModel(for: artists().model) else { return }
        
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
            guard let _ = self else { return }
            
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }

                if topResult.identifier == "Armin van Buuren" && topResult.confidence * 100 > 90 {
                    weakSelf.view?.showCorrectAnswerAlert()
                } else {
                    weakSelf.view?.showWrongAnswerAlert()
                }
            }
        }
        
        guard let CIImage = CIImage(data: data) else { return }
        let handler = VNImageRequestHandler(ciImage: CIImage)
        
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}


