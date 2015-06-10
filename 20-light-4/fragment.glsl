precision mediump float;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 ambient;
uniform vec3 diffuse;
uniform vec3 specular;

uniform vec3 lightPosition;

uniform float shininess;

varying vec3 vLightPosition;
varying vec3 vViewPosition;
varying vec3 vNormal;

void main() {

  // Normalize interpolated vectors
  vec3 eyeDirection = normalize(vViewPosition);
  vec3 normal = normalize(vNormal);
  vec3 lightDirection = normalize(vLightPosition - vViewPosition);

  vec3 rlight = reflect(lightDirection, normal);
  float eyeLight = max(dot(rlight, eyeDirection), 0.0);
  float phong = pow(eyeLight, shininess);

  // float lambert = max(dot(normal, vLightDirection), 0.0); // <- Should be correct. Bug with shader-school?
  float lambert = dot(normal, lightDirection);

  vec3 finalColor = ambient + diffuse * lambert + specular * phong;
  gl_FragColor = vec4(finalColor, 1.0);
}