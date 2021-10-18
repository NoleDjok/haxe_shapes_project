package ;
import openfl.events.Event;
class CusomEvents extends Event {
    public var data:Dynamic;

    public function new(type:String, data:Dynamic, bubbles:Bool = false, cancelable:Bool = false) {
        super(type, bubbles, cancelable);
        this.data = data;
    }

    override public function clone():Event {
        return new CusomEvents(type, bubbles, cancelable);
    }
}
