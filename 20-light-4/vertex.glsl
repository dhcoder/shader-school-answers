precision mediump float;

attribute vec3 position;
attribute vec3 normal;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 lightPosition;

varying vec3 vLightPosition;
varying vec3 vViewPosition;
varying vec3 vNormal;

void main() {
  vec4 viewPosition = view * model * vec4(position, 1.0);
  gl_Position = projection * viewPosition;

  // See https://www.cs.uaf.edu/2007/spring/cs481/lecture/01_23_matrices.html, "Normal Matrix"
  vNormal = (vec4(normal, 0.0) * inverseModel * inverseView).xyz;

  // Light: world to view coordinates, same space as the eye is in
  vLightPosition = (view * vec4(lightPosition, 1.0)).xyz;

  vViewPosition = viewPosition.xyz;
}