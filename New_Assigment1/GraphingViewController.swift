//
//  GraphingViewController.swift
//  New_Assigment1
//
//  Created by Younoussa Ousmane Abdou on 1/9/17.
//  Copyright © 2017 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class GraphingViewController: UIViewController {

    // Variables/Constants/Computed Properties
    
    // Outlets
    @IBOutlet private weak var graphingView: GraphingView! {
        
        didSet {
            
            let pinchGesture = UIPinchGestureRecognizer(target: graphingView, action: #selector(GraphingView.changeScale(recognizer:)))
            graphingView.addGestureRecognizer(pinchGesture)
            
        }
    }
    

    // Actions
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
