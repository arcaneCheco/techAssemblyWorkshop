uniform float uTime;
uniform vec2 uViewport;

float scene(vec3 position) {
    // sphere
    vec3 spherePosition = vec3(0., 0., 3.);
    float sphereRadius = 0.5;
    float sphereDistance = length(spherePosition - position) - sphereRadius;

    // ground
    float groundHeight = -0.5;
    float groundDistance = position.y - groundHeight;

    float dScene = min(sphereDistance, groundDistance);

    return dScene;
}

float rayMarch(vec3 origin, vec3 direction) {
    float dOrigin = 0.;

    for (int i=0; i<100; i++) {
        // get position
        vec3 position = origin + dOrigin * direction;
        // get closest distance to scene
        float dScene = scene(position);
        // march
        dOrigin += dScene;
        // check for intersection
        if (dScene < 0.001 || dOrigin > 10.) break;
    }

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
    vec3 cameraPosition = vec3(0.);
    vec3 rayDirection = normalize(vec3(uv, 1.));

    // cast ray
    float dScene = rayMarch(cameraPosition, rayDirection);

    // shading
    if (dScene < 10.) {
        vec3 lightPosition = vec3(1., 2., 1.5);
        vec3 intersectionPoint = cameraPosition + dScene * rayDirection;
        vec3 lightDirection = normalize(lightPosition - intersectionPoint);
        vec3 surfaceDirection = normal(intersectionPoint);
        float diffuseBrightness = clamp(dot(lightDirection, surfaceDirection), 0., 1.);
        // shadows
        float rayLength = rayMarch(intersectionPoint + 0.002 * surfaceDirection, lightDirection);
        if (rayLength < length(lightPosition - intersectionPoint)) {
            // reduce brightness
            diffuseBrightness *= 0.2;
        }
        color = vec3(diffuseBrightness);
    }
    
	gl_FragColor = vec4(color, 1.);
}