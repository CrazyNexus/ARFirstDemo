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
   
   let configuration: ARConfiguration = ARWorldTrackingConfiguration()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // enable debug information
      sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
      
      // start the AR Sessuin
      sceneView.session.run(configuration)
      sceneView.autoenablesDefaultLighting = true
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   @IBAction func addCube(_ sender: Any) {
      let newNode = SCNNode()
      newNode.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
      newNode.geometry?.firstMaterial?.specular.contents = UIColor.lightGray
      newNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
      
      let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
      let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
      let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
      
      newNode.position = SCNVector3(x, y, z)
      newNode.name = "Box"
      
      sceneView.scene.rootNode.addChildNode(newNode)
   }
   
   @IBAction func reset(_ sender: Any) {
      restartSession()
   }
   
   func restartSession() {
      sceneView.session.pause()
      sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
         if node.name == "Box" {
            node.removeFromParentNode()
         }
      }
      sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
   }
   
   func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
      return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
   }
   
}

