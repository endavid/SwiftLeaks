//
//  ViewController.swift
//  SwiftLeaks
//
//  Created by David Gavilan on 2017/03/04.
//  Copyright © 2017 EnDavid. All rights reserved.
//

import UIKit

enum LeakingEnum {
    case
    LeakCase,
    AnotherLeakCase
}

class Primitive {
    var lightingType: LeakingEnum = .LeakCase
    var mysub : [Int] = []
    init() {
        mysub.append(80)
    }
}

class ViewController: UIViewController {
    var prim: Primitive?
    override func viewDidLoad() {
        super.viewDidLoad()
        prim = Primitive()
    }
}

