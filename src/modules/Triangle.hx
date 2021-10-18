package modules;
import Std.int;

class Triangle extends Base {
    public function new() {
        super();
        this.points = [0, 0, int(this.shapeWidth / 2), this.shapeHeight, this.shapeWidth, 0];

    }
}
