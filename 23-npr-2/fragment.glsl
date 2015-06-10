precision mediump float;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 warm;
uniform vec3 cool;
uniform vec3 lightDirection;

varying vec3 vNormal;

void main() {
  vec3 normal = normalize(vNormal);

  // dot(...) -> -1.0 to 1.0
  // += 1.0   ->  0.0 to 2.0
  // * 0.5    ->  0.0 to 1.0 (the range for using with interpolation)
  float goochWeight = 0.5 * (1.0 + dot(normal, normalize(lightDirection)));
  vec3 goochColor = mix(cool, warm, goochWeight);

  gl_FragColor = vec4(goochColor,1.0);
}