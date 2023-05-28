//
//  ClassificationService.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 24/05/23.
//



import Foundation
import Vision
import UIKit

protocol ClassificationServiceProviding {
    var classificationsResultPub: Published<String>.Publisher { get }
    func updateClassifications(for image: UIImage)
}

final class ClassificationService: ObservableObject, ClassificationServiceProviding {
    
    @Published private var classification = ""
    var classificationsResultPub: Published<String>.Publisher { $classification }
    
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: SnapChef(configuration: MLModelConfiguration()).model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassification(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }()
    
    
    //Request Handler
    func updateClassifications(for image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        
        self.classification = ""
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage)
            
            do{
                try handler.perform([self.classificationRequest])
            }catch{
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }

    func processClassification(for request: VNRequest, error: Error?){
        
        DispatchQueue.main.async {
            guard let result = request.results else {
                return
            }
            
            let classification = result as! [VNClassificationObservation]
            
            if classification.isEmpty{
                
            }else{
                let topClassication = classification.prefix(1)
                let descriptions = topClassication.map {
                    classification in
                    return String(classification.identifier)
                }
                
                self.classification = descriptions.joined(separator: " ")
            }
        }
        
    }
    
}
