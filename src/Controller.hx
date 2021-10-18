package ;
import openfl.events.Event;
import modules.Base;

import openfl.display.Sprite;
import View;
import Model;
class Controller extends Sprite {
    private var Model:Model;
    private var View:View;
    private var timeStart:Float;

    public function new() {
        super();
        this.Model = new Model();
        this.View = new View();
    }

    public function init():Void {
        this.View.init(Model.getData());
        timeStart = Date.now().getTime();
        addEventListener(Event.ENTER_FRAME, onUpdate);
        this.View.addEventListener(TextConstants.SHAPE_CLICK, (event:CusomEvents) -> onClickShape(event.data));
        this.View.addEventListener(TextConstants.SCENE_CLICK, (event:CusomEvents) -> sceneClick(event.data));
        this.View.addEventListener(TextConstants.UPDATE_GRAVITY, (event:CusomEvents) -> {
            this.Model.updateGravity(event.data);
            this.View.onGravityChange(this.Model.getData().gravityValue);
        });
        this.View.addEventListener(TextConstants.UPDATE_SHAPES_PER_SEC, (event:CusomEvents) -> {
            this.Model.updateShapesNumberPerSec(event.data);
            this.View.onShapesPerSecChange(this.Model.getData().shapesPerSec);
        });
    }

    public function sceneClick(data) {
        var shape = this.handleNewShape(data);
    }

    private function onUpdate(event:Event):Void {
        var data:Types.Data = this.Model.getData();
        var dt:Float = (Date.now().getTime() - timeStart) / 1000;
        timeStart = Date.now().getTime();
        this.Model.t += dt;

        if (this.Model.t > 1 / data.shapesPerSec) {
            this.Model.t = 0;
            timeStart = Date.now().getTime();
            this.handleNewShape();
        }
        this.fallShapeDown();
    }

    private function fallShapeDown() {

        var data = this.Model.getData();
        var gravity = data.gravityValue;
        var shapesMap = data.shapes;
        for (shape in shapesMap) {
            var graphic:Base = shape;
            this.View.fallShapeDownView(graphic, gravity);

            if (graphic.shape.y > data.sceneHeight + graphic.height) {
                this.onClickShape(graphic);
            }
        }
    }

    private function onClickShape(graphic:Base) {
        this.Model.removeShape(graphic.id);
        this.View.onShapesCountChange(this.Model.getData().shapes);
        this.View.removeShapeView(graphic.shape);
    }

    private function handleNewShape(isCLick:Bool = false):Base {
        var typeOfShape:String = this.Model.getRandom(this.Model.shapeTypes);
        var shapeColor:Int = this.Model.getRandom(this.Model.shapeColors);
        var shape = this.View.newShape(typeOfShape);
        shape.x = this.mouseX - shape.shapeWidth / 2;
        shape.y = this.mouseY - shape.shapeHeight / 2;
        shape.init(typeOfShape, shapeColor, this.Model.getData(), isCLick);
        this.Model.saveToCollection(shape);
        this.View.onShapesCountChange(this.Model.getData().shapes);

        this.View.render(shape);
        return shape;
    }
}
