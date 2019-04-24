import { Engine, Scene, ArcRotateCamera, Vector3, MeshBuilder, Mesh, DirectionalLight } from "babylonjs";
class Program {
    private static smCanvas: HTMLCanvasElement = null;
    private static smEngine: Engine = null;
    public static main() {
        this.smCanvas = document.getElementById("renderCanvas") as HTMLCanvasElement;
        this.smEngine = new Engine(this.smCanvas, true, { preserveDrawingBuffer: true }, true);
        this.smEngine.setHardwareScalingLevel(0.5);
 
        var scene: Scene = this._createScene(this.smEngine, this.smCanvas);
        this.smEngine.runRenderLoop(() => {
            scene.render();
        });
        window.addEventListener("resize", () => {
            this.smEngine.resize();
        })
    }
    private static _createScene(engine: Engine, canvas: HTMLCanvasElement): Scene {
        var scene: Scene = new Scene(engine);
 
        var camera: ArcRotateCamera = new ArcRotateCamera("Camera", Math.PI / 2, Math.PI / 2, 2, Vector3.Zero(), scene);
        camera.attachControl(canvas, true);
 
        var light: DirectionalLight = new DirectionalLight("light", new Vector3(-1, -1, 0), scene);
 
        var sphere: Mesh = MeshBuilder.CreateSphere("sphere", { diameter: 1 }, scene);
 
        return scene;
    }
}
Program.main();