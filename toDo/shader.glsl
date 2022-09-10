#define PATTERN_5

uniform float uTime;
varying vec2 vUv;

vec3 getColor(vec2 uv) {
    vec3 color = vec3(0.);

    #ifdef PATTERN_1
        color = vec3(uv, 0.);
    #endif

    #ifdef PATTERN_2
        color = vec3(uv, 1.);
    #endif

    #ifdef PATTERN_3
        color = vec3(uv.x);
    #endif

    #ifdef PATTERN_4
        color = vec3(1. - uv.y);
    #endif

    #ifdef PATTERN_5
        color = vec3(abs(uv.x - (sin(uTime * 2.) + 1.) * 0.5));
    #endif

    #ifdef PATTERN_6
        float c = uv.x * 4.;
        c = fract(c);
        color = vec3(c);
    #endif

    #ifdef PATTERN_7
        float c = uv.x * 10.;
        c = fract(c);
        c = step(0.5, c);
        color = vec3(c);
    #endif

    #ifdef PATTERN_8
        float c = uv.x * 10.;
        c = fract(c);
        c = step(0.8, c);
        float d = uv.y * 10.;
        d = fract(d);
        d = step(0.8, d);
        color = vec3(c + d);
    #endif

    #ifdef PATTERN_9
        float c = uv.x * 10.;
        c = fract(c);
        c = step(0.8, c);
        float d = uv.y * 10.;
        d = fract(d);
        d = step(0.8, d);
        color = vec3(c * d);
    #endif

    #ifdef PATTERN_10
        float c = floor(uv.x * 10.) / 10.;
        color = vec3(c);
    #endif

    #ifdef PATTERN_11
        float c = floor(uv.x * 10.) / 10.;
        c *= floor(uv.y * 10.) / 10.;
        color = vec3(c);
    #endif

    #ifdef PATTERN_12
        float c = distance(uv, vec2(0.5));
        color = vec3(c);
    #endif

    #ifdef PATTERN_13
        float c = distance(uv, vec2(0.5));
        c = step(0.2, c); 
        c = 1. - c;
        color = vec3(c);
    #endif

    #ifdef PATTERN_14
        float c = distance(uv, vec2(0.5));
        c = step(0.2, c); 
        c = 1. - c;
        float d = distance(uv, vec2(0.5));
        d = 1. - step(0.18, d); 
        c -= d;
        color = vec3(c);
    #endif

    #ifdef PATTERN_15
        float c = 0.02 / (distance(uv, vec2(0.5)));
        color = vec3(c);
    #endif
    
    return color;
}


void main() {
    vec2 uv = vUv;

    vec3 color = getColor(uv);
    gl_FragColor = vec4(color, 1.);
}

