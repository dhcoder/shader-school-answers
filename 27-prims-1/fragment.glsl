precision highp float;

const vec2 center = vec2(0.5, 0.5);
const float radius = 0.5; // Unit length 1 circle

varying vec3 vColor;

void main() {
  vec2 distToCenter = center - gl_PointCoord;
  if (length(distToCenter) > radius) {
    discard;
  }

  gl_FragColor = vec4(vColor, 1.0);
}