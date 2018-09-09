//
//  ViewController.swift
//  Intergalctic Fun
//
//  Created by Alaina Rogacki on 9/8/18.
//  Copyright © 2018 Alaina Rogacki. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PlanetViewerVC: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var planetTitle: String!
    let baseNode = SCNNode()
    let planetNode = SCNNode()
    let textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        sceneView.delegate = self
        
        addBaseNode()
        addPlanet()
        addShip()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        sceneView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    
    func addBaseNode() {
        let baseLocation = SCNVector3(0.0, 0.0, -1.0)
        baseNode.position = baseLocation
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    func addPlanet() {
        let planet = SCNSphere(radius: 0.3)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: planetTitle)
        planet.materials = [material]
        planetNode.geometry = planet
        baseNode.addChildNode(planetNode)
        
        let planetRotate = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 20)
        let repeatRotate = SCNAction.repeatForever(planetRotate)
        planetNode.runAction(repeatRotate)
    }
    
    func addShip() {
        let orbitAction = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 6)
        let repeatOrbit = SCNAction.repeatForever(orbitAction)
        
        let shipUpAction = SCNAction.move(to: SCNVector3(-0.35, 0.2, 0), duration: 2)
        let shipDownAction = SCNAction.move(to: SCNVector3(-0.35, -0.2, 0), duration: 2)
        
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        
        shipUpAction.timingMode = .easeInEaseOut
        shipDownAction.timingMode = .easeInEaseOut
        
        let upDown = SCNAction.sequence([shipUpAction, shipDownAction])
        let repeatUpDown = SCNAction.repeatForever(upDown)
        
        if let shipNode = scene?.rootNode.childNode(withName: "ship", recursively: true) {
            shipNode.scale = SCNVector3(0.2, 0.2, 0.2)
            shipNode.position = SCNVector3(-0.35, 0, 0)
            
            let rotateNode = SCNNode()
            baseNode.addChildNode(rotateNode)
            rotateNode.addChildNode(shipNode)
            rotateNode.runAction(repeatOrbit)
            shipNode.runAction(repeatUpDown)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
    
    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            dismiss(animated: true, completion: nil)
        }
    }
}
