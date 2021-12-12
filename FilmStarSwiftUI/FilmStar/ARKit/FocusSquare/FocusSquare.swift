import RealityKit
import MetalKit

class FocusSquare: Entity, HasModel {
    var textureResource: TextureResource?
    
    required init(textureResource: TextureResource?) {
        if let textureResource = textureResource {
        self.textureResource = textureResource
        }
        super.init()
        model = ModelComponent(
            mesh: .generatePlane(
                width: Float(0.5),
                depth: Float(0.5 * Float(textureResource!.height) / Float(textureResource!.width))
            ),
            materials: [])
        
        
        if let surfaceShader = createSurfaceShader() {
            do {
                model?.materials = try [
                    CustomMaterial(
                        surfaceShader: surfaceShader,
                        lightingModel: .lit
                    )
                ]
            } catch {}
        } else {
            model?.materials = [
                SimpleMaterial(
                    color: .green,
                    isMetallic: false
                )
            ]
        }
    }
    
    required init() { fatalError("init() has not been implemented") }
    
    fileprivate func createSurfaceShader() -> CustomMaterial.SurfaceShader? {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let library = device.makeDefaultLibrary()
        else { return nil }
        return CustomMaterial.SurfaceShader(named: "opacityGreenShader", in: library)
    }
}
