import com.leapmotion.leap.*;
public class LeapController{
	Controller controller;
	SimpleListener listener;
	double dist;
	float x;
	float y;
	public LeapController(){
		controller = new Controller();
		listener = new SimpleListener();
		controller.addListener(listener);
	}
	public double getDistance(){
		return listener.getDistance();
	}
	public float getX(){
		return listener.getX();
	}
	public float getY(){
		return listener.getY();
	}
}

class SimpleListener extends Listener{
	double distance;
	float x;
	float y;
	public void onConnect(Controller controller){
		System.out.println("Connected");
	}
	public void onFrame(Controller controller){
		Frame frame = controller.frame();
		HandList hands=frame.hands();
		if(hands.count()>=1){
			Hand hand = hands.get(0);
			Finger thumb = new Finger();
			Finger index = new Finger();
			for(Finger f: hand.fingers()){
				if (f.type()== Finger.Type.TYPE_INDEX)
					index = f;
				else if (f.type()== Finger.Type.TYPE_THUMB)
					thumb = f;
			}
			Vector thumbV = thumb.stabilizedTipPosition();
			Vector indexV = index.stabilizedTipPosition();
			x = (thumbV.getX()+indexV.getX())/2;
			y = (thumbV.getY()+indexV.getY())/2;
			float xd = thumbV.getX()-indexV.getX();
			float yd = thumbV.getY()-indexV.getY();
			float zd = thumbV.getZ()-indexV.getZ();
			distance = Math.pow(xd*xd + yd*yd + zd*zd,.5);
			//System.out.println(distance-10+"");
		} 


	}
	public double getDistance(){
		return distance;
	}
	public float getX(){
		return x;
	}
	public float getY(){
		return y;
	}
}