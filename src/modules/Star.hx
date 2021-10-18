package modules;
class Star extends Base {
    public function new() {
        super();
        this.points = [
            this.shapeWidth / 2, this.shapeHeight*0.8,
            this.shapeWidth / 5-5, this.shapeHeight,
            this.shapeWidth/3,this.shapeHeight/2+5,
            0,this.shapeHeight/2-15,
            this.shapeWidth/3,this.shapeHeight/3,
            
            this.shapeWidth/2,0,
            this.shapeWidth*0.75,this.shapeHeight/3,
            
            this.shapeWidth,this.shapeHeight/3,
            this.shapeWidth*0.75,this.shapeHeight/2+5,
            this.shapeWidth*0.9,this.shapeHeight
        ];
    }
}
