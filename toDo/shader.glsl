// uniform float uTime;
// uniform vec2 uViewport;

// float scene(vec3 position) {
//     // sphere
//     vec3 posSphere = vec3(0., 0., 3.);
//     float sphereRadius = 0.5;
//     float dSphere = length(posSphere - position) - sphereRadius;

//     // ground
//     float groundHeight = -0.5;
//     float dGround = position.y - groundHeight;

//     float dScene = min(dSphere, dGround);


//     return dScene;
// }

// float rayMarch(vec3 origin, vec3 direction) {
//     float dOrigin = 0.;

//     for (int i = 0; i < 100; i++) {
//         // get position
//         vec3 position = origin + dOrigin * direction;
//         // get closest distance to scene
//         float dScene = scene(position);
//         dOrigin += dScene;
//         // check for intersection
//         if (dScene < 0.001 || dOrigin > 10.) break;
//     }

//     return dOrigin;
// }

// vec3 normal(vec3 position) {
//     float d = scene(position);
//     vec2 eps = vec2(0.001, 0.);
//     vec3 n = d - vec3(scene(position - eps.xyy), scene(position - eps.yxy), scene(position - eps.yyx));
//     return normalize(n);
// } 

// void main() {
//     vec2 uv = (gl_FragCoord.xy - 0.5 * uViewport) / uViewport.y;

//     // initialize color
//     vec3 color = vec3(0.);

//     // camera
//     vec3 rayOrigin = vec3(0., 0., 0.);
//     vec3 rayDirection = normalize(vec3(uv, 1.));

//     // cast ray
//     float d = rayMarch(rayOrigin, rayDirection);

//     // shading
//     vec3 lightPosition = vec3(0., 2.5, 3.);
//     lightPosition.xz += vec2(cos(uTime), sin(uTime)) * 2.;
//     if (d < 10.) {
//         vec3 hitPosition = rayOrigin + d * rayDirection;
//         vec3 lightDirection = normalize(lightPosition - hitPosition);
//         vec3 normalDirection = normal(hitPosition);
//         float diffuse = dot(lightDirection, normalDirection);
//         diffuse = clamp(diffuse, 0., 1.);
//         float dLight = length(lightPosition - hitPosition);
//         float d2 = rayMarch(hitPosition + normalDirection * 0.01, lightDirection);
//         if (d2 < dLight) {
//             diffuse *= 0.2;
//         }

//         color = vec3(diffuse);
//     }
    
// 	gl_FragColor = vec4(color, 1.);
// }


void main() {
    gl_FragColor = vec4(1., 0., 0., 1.);
}