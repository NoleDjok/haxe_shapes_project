package modules;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.Shape;
import Std.int;

class Circle extends Base {
    public function new() {
        super();
    }

    public override function draw(shape:Sprite){
        shape.graphics.drawCircle(this.shapeWidth,this.shapeHeight/2,this.shapeHeight/2);
    }

    public override function calcArea() {
        var r = this.shapeHeight / 2;
        this.pixels = int(Math.PI * r * r);
    }
}
