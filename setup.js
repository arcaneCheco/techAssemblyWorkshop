import * as THREE from "three";
import shader from "./toDo/shader.glsl";

class Setup {
  constructor() {
    this.init();
  }

  init() {
    this.time = 0;
    this.container = document.querySelector("#canvas");
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera();
    this.renderer = new THREE.WebGLRenderer();
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.container.appendChild(this.renderer.domElement);
    this.renderer.setClearColor(0x333333);
    window.addEventListener("resize", this.resize.bind(this));

    this.uniforms = {
      uTime: { value: 0 },
      uResolution: { value: { x: 0, y: 0 } },
    };

    const program = new THREE.ShaderMaterial({
      vertexShader: `
        varying vec2 vUv;
        void main() {
          gl_Position = modelMatrix * vec4(position, 1.);
          vUv = uv;
        }
      `,
      fragmentShader: shader,
      uniforms: this.uniforms,
    });
    this.mesh = new THREE.Mesh(new THREE.PlaneGeometry(2, 2), program);
    this.scene.add(this.mesh);
    this.resize();
    this.render();
  }

  resize() {
    this.renderer.setSize(window.innerWidth, window.innerHeight);
    const aspect = window.innerWidth / window.innerHeight;
    aspect >= 1
      ? this.mesh.scale.set(1 / aspect, 1, 1)
      : this.mesh.scale.set(1, aspect, 1);
  }

  render() {
    this.time += 0.01633;
    this.uniforms.uTime.value = this.time;
    this.renderer.render(this.scene, this.camera);
    window.requestAnimationFrame(this.render.bind(this));
  }
}

new Setup();
