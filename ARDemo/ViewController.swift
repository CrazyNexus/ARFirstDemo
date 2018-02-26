//
//  ViewController.swift
//  ARDemo
//
//  Created by Dubiel, Thomas on 26.02.18.
//  Copyright © 2018 Dubiel, Thomas. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
   
   @IBOutlet weak var sceneView: ARSCNView!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      // pprepare the session by creating a World Tracking Configuration
      let configuration = ARWorldTrackingConfiguration()
      
      // enable debug information
      sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
      
      // start the AR Sessuin
      sceneView.session.run(configuration)
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

