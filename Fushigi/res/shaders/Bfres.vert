#version 330

in vec3 aPosition;
in vec3 aNormal;

in vec2 aTexCoord0;
in vec2 aTexCoord1;

in vec4 aTangent;

uniform mat4 mtxCam;    // Camera matrix (view matrix)
uniform mat4 mtxMdl;    // Model matrix

out vec2 TexCoords0;
out vec3 Normals;
out vec4 Tangents;

void main() {
    mat4 mtxMdl_2 = mtxMdl * mat4(
        -1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, -1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );

    // Transform the position from model space to clip space
    vec4 modelViewProjPosition = mtxCam * mtxMdl_2 * vec4(aPosition, 1.0);

    // Flip the Y-coordinate to move the origin to the upper-left
    modelViewProjPosition.y = -modelViewProjPosition.y;

    // Remap depth from [-w, w] to [0, 1]
    //modelViewProjPosition.z = (modelViewProjPosition.z + modelViewProjPosition.w) / (2.0 * modelViewProjPosition.w);

    // Set the final clip space position
    gl_Position = modelViewProjPosition;

    // Pass along the texture coordinates, normals, and tangents
    TexCoords0 = aTexCoord0;
    Normals = mat3(mtxMdl) * aNormal;  // Apply model matrix to normals
    Tangents = aTangent;
}
