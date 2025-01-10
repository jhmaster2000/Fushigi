#version 330

in vec3 aPosition;
in vec3 aNormal;

in vec2 aTexCoord0;
in vec2 aTexCoord1;

in vec4 aTangent;

uniform mat4 mtxCam;
uniform mat4 mtxMdl;

out vec2 TexCoords0;
out vec3 Normals;
out vec4 Tangents;

void main()
{
    // Apply the camera (view) and model transformation
    vec4 transformedPosition = mtxCam * (mtxMdl * vec4(aPosition, 1.0));
    
    // Custom clip space transformations
    // 1. Flip the Y-axis (invert the Y component)
    transformedPosition.y = -transformedPosition.y;

    // 2. Optionally adjust the depth (map from [-1, 1] to [0, 1])
    transformedPosition.z = (transformedPosition.z + 1.0) * 0.5; // Maps [-1, 1] to [0, 1]

    transformedPosition.z = -transformedPosition.z;

    // Set gl_Position to the transformed position
    gl_Position = transformedPosition;

    // Pass the normal, tangent, and texture coordinates to the fragment shader
    Normals = mat3(mtxMdl) * aNormal;

    TexCoords0 = aTexCoord0;
    Tangents = aTangent;
}
