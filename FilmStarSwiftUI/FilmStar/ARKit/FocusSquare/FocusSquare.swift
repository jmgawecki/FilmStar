import RealityKit
import MetalKit

/// Entity that takes the shape of the green opaque bounding box. `FocusSquare` lets the user know where will the `ARPoster` render and appear.
///
/// `FocusSquare` uses custom `opacityGreenShader` Metal base shader. Size of the `FocusSquare` will be that of the Poster that the experience is about to render.
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
            materials: []
        )
        
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
        
        if let geometryModifier = createGeoShader() {
            do {
                let materials = try model?.materials.map { try CustomMaterial(from: $0, geometryModifier: geometryModifier)}
                if let materials = materials {
                    model?.materials = materials
                }
            } catch {}
        }
    }
    
    required init() { fatalError("init() has not been implemented") }
    
    
    /// Builds a metal library and returns the `SurfaceShader` that is later applied to the `FocusSquare`'s custom material to create a green opaque rectangle suggesting where the `ARPoster` is going to be placed.
    fileprivate func createSurfaceShader() -> CustomMaterial.SurfaceShader? {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let library = device.makeDefaultLibrary()
        else { return nil }
        return CustomMaterial.SurfaceShader(named: "opacityGreenShader", in: library)
    }
    
    fileprivate func createGeoShader() -> CustomMaterial.GeometryModifier? {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let library = device.makeDefaultLibrary()
        else { return nil }
        return CustomMaterial.GeometryModifier(named: "testGeoShader", in: library)
    }
}
