//
//  ViewController.swift
//  SwiftLeaks
//
//  Created by David Gavilan on 2017/03/04.
//  Copyright © 2017 EnDavid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scene : Scene?
    var plugin : Plugin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Manager.sharedInstance.initPlugins()
        let prim = PrimitiveHeir()
        scene = Scene()
        prim.queue()
        scene?.primitives.append(prim)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

