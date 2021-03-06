import RealityKit

/// AR Poster class represents the Entity for rendering virtual poster onto the wall of the room.
class ARPoster: Entity, HasModel, HasCollision {
    
    required init(with textureResource: TextureResource) {
        super.init()
        generatePoster(with: textureResource)
        generateCollisionShapes(recursive: false)
    }
    
    required init() { fatalError("init() has not been implemented") }
    
    // MARK: - HasModel
    fileprivate func generatePoster(with textureResource: TextureResource) {
        var material = UnlitMaterial()
        material.baseColor = MaterialColorParameter.texture(textureResource)
        material.tintColor = .white.withAlphaComponent(0.99)
        
        model = ModelComponent(
            mesh: .generatePlane(
                width: Float(0.5),
                depth: Float(0.5 * Float(textureResource.height) / Float(textureResource.width))
            ),
            materials: [material]
        )
    }
}
