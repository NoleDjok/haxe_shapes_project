package modules;
import openfl.display.Sprite;
import openfl.display.Shape;
class Square extends Base {
    public function new() {
        super();
    }

    public override function draw(shape:Sprite){
        shape.graphics.drawRect(0,0,this.shapeWidth,this.shapeHeight);
    }

    public override function calcArea() {
    this.pixels = this.shapeWidth * this.shapeHeight;
    }
}
