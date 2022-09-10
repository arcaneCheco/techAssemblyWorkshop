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
    window.addEventListener("resize", this.resize.bind(this));

    this.uniforms = {
      uTime: { value: 0 },
      uViewport: { value: { x: 0, y: 0 } },
    };

    const program = new THREE.ShaderMaterial({
      vertexShader: `
        void main() {
          gl_Position = vec4(position, 1.);
        }
      `,
      fragmentShader: shader,
      uniforms: this.uniforms,
    });
    const mesh = new THREE.Mesh(new THREE.PlaneGeometry(2, 2), program);
    this.scene.add(mesh);
    this.resize();
    this.render();
  }

  resize() {
    this.renderer.setSize(window.innerWidth, window.innerHeight);
    this.uniforms.uViewport.value.x = window.innerWidth;
    this.uniforms.uViewport.value.y = window.innerHeight;
  }

  render() {
    this.time += 0.01633;
    this.uniforms.uTime.value = this.time;
    this.renderer.render(this.scene, this.camera);
    window.requestAnimationFrame(this.render.bind(this));
  }
}

new Setup();
