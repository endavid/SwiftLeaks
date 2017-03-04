//
//  Primitive.swift
//  SwiftLeaks
//
//  Created by David Gavilan on 2017/03/04.
//  Copyright © 2017 EnDavid. All rights reserved.
//

import Foundation
import Metal
import MetalKit
import simd

struct Vec2 {
    let x : Float
    let y : Float
    init(_ x: Float, _ y: Float) {
        self.x = x
        self.y = y
    }
}
struct Material {
    static let white = Material(
        uvScale: Vec2(1,1),
        uvOffset: Vec2(0,0)
    )
    var uvScale : Vec2
    var uvOffset : Vec2
}
struct Transform {
    var position = float3(0, 0, 0)
}

struct PerInstanceUniforms {
    var transform : Transform
    var material : Material
}

enum LightingType {
    case
    LitOpaque,
    UnlitTransparent
}

class Primitive {
    internal var vertexBuffer : MTLBuffer!
    var name: String = ""
    let uniformBuffer : MTLBuffer!
    var lightingType: LightingType = .LitOpaque
    var submeshes: [Mesh] = []
    var mysub : [MyTest] = []
    
    init() {
        self.uniformBuffer = nil// RenderManager.sharedInstance.createPerInstanceUniformsBuffer("primUniforms", numElements: RenderManager.NumSyncBuffers * numInstances)
    }
    struct Mesh {
        var numIndices: Int
        var indexBuffer: MTLBuffer?
        // this is not in the Material because it can only be set for ALL instances
        var albedoTexture: MTLTexture?
        init() {
            self.init(numIndices: 0, indexBuffer: nil, albedoTexture: nil)
        }
        init(numIndices: Int, indexBuffer: MTLBuffer?, albedoTexture: MTLTexture?) {
            self.numIndices = numIndices
            self.indexBuffer = indexBuffer
            self.albedoTexture = albedoTexture
        }
    }
    struct MyTest {
        var someNumber : Int
    }
}

class SpherePrimitive : Primitive {
    override init() {
        super.init()
        mysub.append(MyTest(someNumber: 80))
    }
}

class Scene {
    var primitives : [Primitive] = []
}

class MyScene : Scene {
    override init() {
        super.init()
        setup()
    }
    func setup() {
        let spheres = SpherePrimitive()
        primitives.append(spheres)
    }
}

