uniform float uTime;
uniform vec2 uViewport;

float scene(vec3 position) {
    return 100.;
}

float rayMarch(vec3 origin, vec3 direction) {
    vec3 position = origin;

    float dOrigin = 100.;

    return dOrigin;
}

vec3 normal(vec3 position) {
    float d = scene(position);
    vec2 eps = vec2(0.001, 0.);
    vec3 n = d - vec3(scene(position - eps.xyy), scene(position - eps.yxy), scene(position - eps.yyx));
    return normalize(n);
} 

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * uViewport) / uViewport.y;

    // initialize color
    vec3 color = vec3(0.);

    // camera

    // cast ray

    // shading
    
	gl_FragColor = vec4(color, 1.);
}