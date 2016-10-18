//
//  EmotionsViewController.swift
//  FaceWithSwift
//
//  Created by Ivan Kurhanskyi on 9/17/16.
//  Copyright © 2016 Ivan Kurhanskyi. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "angry": FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischivieous": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin),
    ]

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    facevc.expression = expression
                }
            }
        }
        
    }
    

}
