package ;
import openfl.utils.Object;
import modules.Star;
import modules.Hexagon;
import modules.Square;
import modules.Circle;
import modules.Triangle;
import modules.Pentagon;
import modules.Ellipse;
import openfl.display.Stage;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import modules.Base;
import Lambda;
import Std.string;
import TextConstants;


class View extends Sprite {

    private var timeStart:Float;
    private var ShapeContainer:Sprite;

    // this for prevent deleting shape and create new one in the one time
    private var isClickOnShape:Bool = false;

    public function new() {
        super();
    }


    public function init(data:Types.Data):Void {
        var stage = new Stage(data.sceneWidth, data.sceneHeight, View);
        stage.addChild(this);
        js.Browser.document.getElementById("stage").appendChild(stage.element);
        stage.addEventListener(MouseEvent.CLICK, (event:MouseEvent) -> sceneClick());

        js.Browser.document.getElementById('btn-gravity-decrement').addEventListener('click', (event:CusomEvents) -> updateGravity(-1));
        js.Browser.document.getElementById('btn-gravity-increment').addEventListener('click', (event:CusomEvents) -> updateGravity(1));
        js.Browser.document.getElementById('btn-shapes-number-decrement').addEventListener('click', (event:CusomEvents) -> updateShapesNumber(-1));
        js.Browser.document.getElementById('btn-shapes-number-increment').addEventListener('click', (event:CusomEvents) -> updateShapesNumber(1));
        this.onGravityChange(data.gravityValue);
        this.onShapesPerSecChange(data.shapesPerSec);
        this.onShapesCountChange(data.shapes);
    }

    public function updateGravity(value:Int) {
        this.dispatchEvent(new CusomEvents(TextConstants.UPDATE_GRAVITY, value));
    }

    public function updateShapesNumber(value:Int) {

        this.dispatchEvent(new CusomEvents(TextConstants.UPDATE_SHAPES_PER_SEC, value));
    }

    public function newShape(type:String):Base {
        var shape:Base;
        switch (type) {
            case '5 sides':
                shape = new Pentagon();
            case '3 sides':
                shape = new Triangle();
            case 'square':
                shape = new Square();
            case 'circle':
                shape = new Circle();
            case 'ellipse':
                shape = new Ellipse();
            case '6 sides':
                shape = new Hexagon();
            case 'star':
                shape = new Star();
            default:
                shape = new Square();

        }
        return shape;
    }

    public function render(sprite:Base) {
        sprite.shape = new Sprite();
        sprite.shape.graphics.beginFill(sprite.color); //set the color
        sprite.draw(sprite.shape);
        sprite.setPos(sprite.x, sprite.y);
        sprite.shape.graphics.endFill();
        this.buttonMode = true;
        sprite.buttonMode = true;
        this.addChild(sprite.shape).addEventListener(MouseEvent.CLICK, (event:CusomEvents) -> shapeClickHandler(sprite));
    }

    private function shapeClickHandler(sprite:Base):Void {
        this.isClickOnShape = true;
        this.dispatchEvent(new CusomEvents(TextConstants.SHAPE_CLICK, sprite));
    }

    private function sceneClick():Void {
        if (!isClickOnShape) {
            this.dispatchEvent(new CusomEvents(TextConstants.SCENE_CLICK, true));
        }
        this.isClickOnShape = false;
    }

    public function removeShapeView(shape:Sprite) {
        this.removeChild(shape);
    }

    public function fallShapeDownView(graphic:Base, gravity:Int) {
        graphic.shape.y += gravity;
    }

    public function onGravityChange(gravity:Int) {
        js.Browser.document.getElementById('footer-gravity').innerText = TextConstants.GRAVITY + Std.string(gravity);

    }

    public function onShapesPerSecChange(shapesPerSec:Int) {
        js.Browser.document.getElementById('footer-number-of-shapes').innerText = TextConstants.SHAPES_PER_SEC + Std.string(shapesPerSec);
    }

    public function onShapesCountChange(shapesMap:Map<String, Base>) {
        var totalPixels:Float = 0;
        for (shape in shapesMap) {
            var graphic:Base = shape;
            totalPixels += graphic.pixels;
        }

        js.Browser.document.getElementById('shapesNumber').innerHTML = TextConstants.NUM_SHAPES + string(Lambda.count(shapesMap));
        js.Browser.document.getElementById('shapesArea').innerHTML = TextConstants.PIXELS + string(totalPixels);
    }
}
