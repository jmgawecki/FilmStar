//
//  testShader.metal
//  FilmStar
//
//  Created by Jakub Gawecki on 26/03/2022.
//

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>

using namespace metal;

[[visible]]
void testGeoShader(realitykit::geometry_parameters params)
{
    float3 localPosition = params.geometry().model_position();
    
    float offsetMultiplier = sin(params.uniforms().time() * 3);
    
    if (localPosition.y > 0)
    {
        params.geometry().set_model_position_offset(float3(localPosition.x * offsetMultiplier, 0, localPosition.z * offsetMultiplier));
    }
}

