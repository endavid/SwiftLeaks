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

class Primitive {
    internal var vertexBuffer : MTLBuffer!
    let priority : Int
    var name: String = ""
    var perInstanceUniforms : [PerInstanceUniforms]
    let uniformBuffer : MTLBuffer!
    var submeshes: [Mesh] = []
    var mysub : [MyTest] = []
    
    var numInstances : Int {
        get {
            return perInstanceUniforms.count
        }
    }
    init(priority: Int, numInstances: Int) {
        self.priority = priority
        self.perInstanceUniforms = [PerInstanceUniforms](repeating: PerInstanceUniforms(transform: Transform(), material: Material.white), count: numInstances)
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

struct SphereDescriptor {
    let isRegularGrid: Bool
    let isInterior: Bool
    let tessellationLevel: Int // only for non-regular grids
    let widthSegments: Int // only for regular grids
    let heightSegments: Int // only for regular grids
}

class SpherePrimitive : Primitive {
    // this could probably be a series of flags, hasInterior & hasExterior
    fileprivate let isInterior : Bool
    
    
    /// @param tesselationLevel: 2: 162 vertices; 3: 642 vertices; 4: 2562 vertices
    init(priority: Int, numInstances: Int, descriptor: SphereDescriptor) {
        self.isInterior = descriptor.isInterior
        super.init(priority: priority, numInstances: numInstances)
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
        let sphereDesc = SphereDescriptor(isRegularGrid: false, isInterior: false, tessellationLevel: 2, widthSegments: 0, heightSegments: 0)
        let spheres = SpherePrimitive(priority: 0, numInstances: 1, descriptor: sphereDesc)
        primitives.append(spheres)
    }
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
