package modules;
class Hexagon extends Base {
    public function new() {
        super();
        this.points = [60, 0, this.shapeWidth, 30, this.shapeWidth, 90, 60, this.shapeHeight, 0, 90, 0, 30];
    }
}
