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

private struct Constants {
    static let classifierConfidence: Float = 90
}

class WinTicketsPresenter {
    weak var view: WinTicketsView?
    
    init(view: WinTicketsView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.hideAllContent()
        
        view?.startActivityIndicator()
        QuestionService.instance.getRandomQuestion { [weak self] (success) in
            guard let weakSelf = self else { return }
            weakSelf.view?.stopActivityIndicator()
            
            if success {
                guard let question = QuestionService.instance.question?.question else { return }
                weakSelf.view?.displayAllContent()
                weakSelf.view?.displayQuestion(question)
            } else {
                // TODO
            }
        }
    }
    
    func beginRecognitionProcess(forData data: Data) {
        guard let model = try? VNCoreMLModel(for: artists().model) else { return }
        
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
            guard let _ = self else { return }
            
            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else { return }
            
                guard let question = QuestionService.instance.question else { return }
        
                if topResult.identifier == question.answer && topResult.confidence * 100 > Constants.classifierConfidence {
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let weakSelf = self else { return }
                        weakSelf.view?.showCorrectAnswerAlert()
                    }
                    
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let weakSelf = self else { return }
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


