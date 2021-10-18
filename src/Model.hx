package ;
import modules.Base;
import openfl.events.Event;
import openfl.events.EventDispatcher;

class Model {
    public var data:Types.Data = {
        shapes:new Map(),
        shapesPerSec : 1,
        gravityValue : 3,
        sceneWidth : Constants.SCENE_WIDTH,
        sceneHeight : Constants.SCENE_HEIGHT,
    }
    public var shapeTypes:Array<String> = ['3 sides',  '5 sides', '6 sides', 'star','circle', 'ellipse','square'];
    public var shapeColors:Array<Int> = [0x00FFFF, 0xFF0000, 0x00FF00, 0x0000FF, 0xe74c3c, 0x3498db, 0x9b59b6, 0x2c3e50, 0xf1c40f];
    public var t:Float = 0;


    public function new() {

    }

    public function getData():Types.Data {
        return data;
    }

    public function getRandom(value:Array<Dynamic>):Dynamic{
        return value[Math.floor(Math.random() * this.shapeColors.length)];
    }

    public function saveToCollection(shape:Base) {
        this.data.shapes.set(shape.id, shape);
        shape.calcArea();
    }

    public function removeShape(id:String) {
        this.data.shapes.remove(id);
    }

    public function updateGravity(offset = 0) {
        var gravityValue = this.data.gravityValue;
        if (gravityValue + offset < 1 || gravityValue + offset > 10) {
            return;
        }

        this.data.gravityValue = gravityValue + offset;
    }

    public function updateShapesNumberPerSec(offset = 0) {

        var gravityValue = this.data.shapesPerSec;
        if (gravityValue + offset < 1 || gravityValue + offset > 10) {
            return;
        }

        this.data.shapesPerSec = gravityValue + offset;
    }
}
