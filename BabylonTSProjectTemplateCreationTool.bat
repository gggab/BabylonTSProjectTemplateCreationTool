@echo off
call npm init -y
call cnpm install --save-dev typescript webpack ts-loader webpack-cli
call cnpm install --save babylonjs@4.0.0-beta.6

@echo const path = require("path");                       >> webpack.config.js
@echo module.exports = {                                  >> webpack.config.js
@echo     entry: './assets/scripts/index.ts',             >> webpack.config.js
@echo     output: {                                       >> webpack.config.js
@echo         filename: 'index.js',                       >> webpack.config.js
@echo         path: path.resolve(__dirname, 'src')        >> webpack.config.js
@echo     },                                              >> webpack.config.js
@echo     resolve: {                                      >> webpack.config.js
@echo         extensions: [".ts"]                         >> webpack.config.js
@echo     },                                              >> webpack.config.js
@echo     module: {                                       >> webpack.config.js
@echo         rules: [                                    >> webpack.config.js
@echo             { test: /\.tsx?$/, loader: "ts-loader" }>> webpack.config.js
@echo         ]                                           >> webpack.config.js
@echo     },                                              >> webpack.config.js
@echo     mode: "development",                            >> webpack.config.js
@echo     devtool: "source-map",                          >> webpack.config.js
@echo     watch: false                                    >> webpack.config.js
@echo };                                                  >> webpack.config.js

@echo {                                  >tsconfig.json
@echo   "compilerOptions": {             >>tsconfig.json
@echo     "target": "es5",               >>tsconfig.json
@echo     "module": "commonjs",          >>tsconfig.json
@echo     "noResolve": false,            >>tsconfig.json
@echo     "noImplicitAny": false,        >>tsconfig.json
@echo     "removeComments": true,        >>tsconfig.json
@echo     "preserveConstEnums": true,    >>tsconfig.json
@echo     "sourceMap": true,             >>tsconfig.json
@echo     "experimentalDecorators": true,>>tsconfig.json 
@echo     "isolatedModules": false,      >>tsconfig.json 
@echo     "lib": [                       >>tsconfig.json 
@echo       "dom",                       >>tsconfig.json 
@echo       "es2015.promise",            >>tsconfig.json 
@echo       "es5"                        >>tsconfig.json 
@echo     ],                             >>tsconfig.json 
@echo     "declaration": true,           >>tsconfig.json 
@echo     "outDir": "./src"             >>tsconfig.json 
@echo   }                                >>tsconfig.json 
@echo }                                  >>tsconfig.json 


@echo ^<!DOCTYPE html^>                                      >index.html
@echo ^<html^>                                               >>index.html
@echo=                                                       >>index.html
@echo ^<head^>                                               >>index.html
@echo     ^<style^>                                          >>index.html
@echo         html,                                          >>index.html
@echo         body {                                         >>index.html
@echo             overflow: hidden;                          >>index.html
@echo             width: 100%%;                               >>index.html
@echo             height: 100%%;                              >>index.html
@echo             margin: 0;                                 >>index.html
@echo             padding: 0;                                >>index.html
@echo             text-align: center;                        >>index.html
@echo         }                                              >>index.html
@echo=                                                       >>index.html
@echo         #renderCanvas {                                >>index.html
@echo             width: 100%%;                               >>index.html
@echo             height: 100%%;                              >>index.html
@echo             touch-action: none;                        >>index.html
@echo         }                                              >>index.html
@echo     ^</style^>                                         >>index.html
@echo ^</head^>                                              >>index.html
@echo=                                                       >>index.html
@echo ^<body^>                                               >>index.html
@echo     ^<canvas id="renderCanvas"^>^</canvas^>            >>index.html
@echo     ^<script src="src/index.js"^>^</script^>          >>index.html
@echo ^</body^>                                              >>index.html
@echo=                                                       >>index.html
@echo ^</html^>                                              >>index.html

md "assets"
cd assets
md "scripts"
cd scripts

@echo import { Engine, Scene, ArcRotateCamera, Vector3, MeshBuilder, Mesh, DirectionalLight } from "babylonjs";>>index.ts
@echo class Program {>>index.ts
@echo     private static smCanvas: HTMLCanvasElement = null;>>index.ts
@echo     private static smEngine: Engine = null;>>index.ts
@echo     public static main() {>>index.ts
@echo         this.smCanvas = document.getElementById("renderCanvas") as HTMLCanvasElement;>>index.ts
@echo         this.smEngine = new Engine(this.smCanvas, true, { preserveDrawingBuffer: true }, true);>>index.ts
@echo         this.smEngine.setHardwareScalingLevel(0.5);>>index.ts
@echo= >>index.ts
@echo         var scene: Scene = this._createScene(this.smEngine, this.smCanvas);>>index.ts
@echo         this.smEngine.runRenderLoop(() =^> {>>index.ts
@echo             scene.render();>>index.ts
@echo         });>>index.ts
@echo         window.addEventListener("resize", () =^> {>>index.ts
@echo             this.smEngine.resize();>>index.ts
@echo         })>>index.ts
@echo     }>>index.ts
@echo     private static _createScene(engine: Engine, canvas: HTMLCanvasElement): Scene {>>index.ts
@echo         var scene: Scene = new Scene(engine);>>index.ts
@echo= >>index.ts
@echo         var camera: ArcRotateCamera = new ArcRotateCamera("Camera", Math.PI / 2, Math.PI / 2, 2, Vector3.Zero(), scene);>>index.ts
@echo         camera.attachControl(canvas, true);>>index.ts
@echo= >>index.ts
@echo         var light: DirectionalLight = new DirectionalLight("light", new Vector3(-1, -1, 0), scene);>>index.ts
@echo= >>index.ts
@echo         var sphere: Mesh = MeshBuilder.CreateSphere("sphere", { diameter: 1 }, scene);>>index.ts
@echo= >>index.ts
@echo         return scene;>>index.ts
@echo     }>>index.ts
@echo }>>index.ts
@echo Program.main();>>index.ts

cd..
cd..

@echo off&setlocal enabledelayedexpansion
setlocal enableDelayedExpansion
for /f "eol=* tokens=*" %%i in (package.json) do (
set a=%%i
set b="test": "echo \"Error: no test specified\" && exit 1"
if "!a!" == "!b!" (^
	echo "build": "webpack", >>$ ^
)
echo !a!>>$)
move $ package.json
call npm run build
index.html