//
//  Primitive.swift
//  SwiftLeaks
//
//  Created by David Gavilan on 2017/03/04.
//  Copyright © 2017 EnDavid. All rights reserved.
//

import Foundation

class Primitive {
    var someStructArray : [SomeStruct] = []
    func queue() {
        let plugin = Manager.sharedInstance.plugins[0]
        plugin.queue(self)
    }
    struct SomeStruct {
        var someNumber : Int
    }
}

class PrimitiveHeir : Primitive {
    override init() {
        super.init()
        someStructArray.append(SomeStruct(someNumber: 66))
    }
}

class Scene {
    var primitives : [Primitive] = []
}

class Plugin {
    var primitives : [Primitive] = []
    func queue(_ primitive: Primitive) {
        primitives.append(primitive)
    }
}

class Manager {
    static let sharedInstance = Manager()
    var plugins : [Plugin] = []
    func initPlugins() {
        plugins.append(Plugin())
    }
}
