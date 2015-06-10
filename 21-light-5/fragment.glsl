precision mediump float;

#pragma glslify: PointLight = require(./light.glsl)

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 inverseModel;
uniform mat4 inverseView;
uniform mat4 inverseProjection;

uniform vec3 ambient;

uniform PointLight lights[4];

varying vec3 vViewPosition;
varying vec3 vNormal;

void main() {
  // Normalize interpolated vectors
  vec3 eyeDirection = normalize(vViewPosition);
  vec3 normal = normalize(vNormal);

  vec3 finalColor = ambient;
  for (int i = 0; i < 4; i++) {
  	PointLight light = lights[i];
  	vec3 viewLightPosition = (view * vec4(light.position, 1.0)).xyz;
    vec3 lightDirection = normalize(viewLightPosition - vViewPosition);

    vec3 rlight = reflect(lightDirection, normal);
    float eyeLight = max(dot(rlight, eyeDirection), 0.0);
    float phong = pow(eyeLight, light.shininess);

    // float lambert = max(dot(normal, vLightDirection), 0.0); // <- Should be correct. Bug with shader-school?
    float lambert = dot(normal, lightDirection);

    finalColor += light.diffuse * lambert + light.specular * phong;
  }

  gl_FragColor = vec4(finalColor, 1.0);
}