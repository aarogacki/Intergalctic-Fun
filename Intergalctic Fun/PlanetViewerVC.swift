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
    
    var planet: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        sceneView.delegate = self

//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
}
