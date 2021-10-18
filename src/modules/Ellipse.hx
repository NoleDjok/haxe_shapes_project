package modules;
import openfl.display.Sprite;
import Std.int;

class Ellipse extends Base {
    public function new() {
        super();
    }

    public override function draw(shape:Sprite) {
        shape.graphics.drawEllipse(0, 0, this.shapeWidth + this.shapeHeight / 2, this.shapeHeight);
    }

    public override function calcArea() {
        var r = this.shapeHeight / 3;
        var R = this.shapeWidth / 2;
        this.pixels = int(Math.PI * R * r);
    }
}
