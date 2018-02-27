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
      //newNode.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
      //newNode.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
      
      // https://developer.apple.com/documentation/scenekit/built_in_geometry_types
      
      let path = UIBezierPath()
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: 0, y: 0.2))
      path.addLine(to: CGPoint(x: 0.2, y: 0.1))
      let shape = SCNShape(path: path, extrusionDepth: 0.1)
      newNode.geometry = shape
      
      newNode.geometry?.firstMaterial?.specular.contents = UIColor.lightGray
      newNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
      
      newNode.position = SCNVector3(0, 0, -0.7)
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

