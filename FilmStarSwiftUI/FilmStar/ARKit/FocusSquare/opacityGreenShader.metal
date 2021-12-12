#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
using namespace metal;


[[visible]]
void opacityGreenShader(realitykit::surface_parameters params)
{
    params.surface().set_base_color(half3(0.094, 0.697, 0.088));
    params.surface().set_opacity(0.3);
    params.surface().set_roughness(0.9);
}



