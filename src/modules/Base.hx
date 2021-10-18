package modules;
import openfl.display.Sprite;
import openfl.Vector;

import openfl.display.GraphicsPathCommand;
import Std.int;
import Std.string;


class Base extends Sprite {
    public var shape:Sprite;

    public var id:String;

    public var type:String = 'base';
    public var color = null;
    public var points:Array<Float>;
    public var pixels:Int;
    public var shapeWidth:Int = Constants.SHAPE_WIDTH;
    public var shapeHeight:Int = Constants.SHAPE_HEIGHT;

    public function new() {
        super();
        this.points = [];
        this.x = 0;
        this.y = 0;
        this.buttonMode = true;
    }


    public function init(type:String, color:Int, data:Types.Data, isClick:Bool) {
        if (!isClick) {
            this.x = Math.floor(Math.random() * (data.sceneWidth - this.shapeWidth));
            this.y = -this.shapeHeight;
        }

        this.type = type;
        this.color = color;
        this.id = (string(Date.now().getTime())) + string(Math.random()).substr(2);
    }

    public function setPos(x:Float, y:Float) {
        this.shape.x = x;
        this.shape.y = y;
    }

    public function draw(shape:Sprite) {
        var squareCommands = new Vector<Int> (int(this.points.length / 2), true);
        var squareCoord = new Vector<Float> (this.points.length, true);
        squareCommands[0] = GraphicsPathCommand.MOVE_TO;

        for (i in 0...this.points.length) {
            squareCoord[i] = points[i];
            if (i < this.points.length && i != 0) {
                squareCommands[i] = GraphicsPathCommand.LINE_TO;
            }
        }
        shape.graphics.drawPath(squareCommands, squareCoord);
    }

    public function calcArea() {
        var area:Float = 0;

        for (i in 0... int(this.points.length / 2)) {
            var x1:Float = 0;
            var y1:Float = 0;
            var x2:Float = 0;
            var y2:Float = 0;
            
            x1 = this.points[i * 2];
            x2 = this.points[((i * 2) + 2) % this.points.length];
            y1 = this.points[i * 2 + 1];
            y2 = this.points[((i * 2 + 1) + 2) % this.points.length];
            area += x1 * y2 - x2 * y1;
        }
        this.pixels = int(Math.abs(area) / 2);
    }
}
