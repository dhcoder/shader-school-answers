precision highp float;

uniform sampler2D prevState;
uniform vec2 stateSize;

float state(vec2 coord) {
  return texture2D(prevState, fract(coord / stateSize)).r;
}

void main() {
  vec2 coord = gl_FragCoord.xy;
  float s = state(coord);
  float n = 0.0;

  // The world in the game of life is a 2D grid of cells, which we shall assume wraps around
  // at the boundary (so don't worry about out of bounds checking)
  for (int dx = -1; dx <= 1; ++dx) {
    for (int dy = -1; dy <= 1; ++dy) {
      if (dx != 0 || dy != 0) {
        vec2 nCoord = coord + vec2(dx, dy);
        n += state(nCoord);
      }
    }
  }

  // Birth: If a cell is off and has exactly 3 neighbors, it turns on
  // Life: If a cell is on, and has 2 or 3 neighbors it stays on
  // Death: Otherwise, a cell turns off
  float s_ = ((s == 0.0 && n == 3.0) || (s == 1.0 && (n == 2.0 || n == 3.0)) ? 1.0 : 0.0);
  gl_FragColor = vec4(vec3(s_), 1.0);
}
