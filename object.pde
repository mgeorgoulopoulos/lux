class Ray
{
	public PVector start = new PVector();
	public PVector end = new PVector();
	public PVector direction = new PVector(0, 1, 0);
	public float velocity = 0.0f;
	public float length = 0.0f;
	int state = State_Extending;

	public static final int State_Extending = 1;
	public static final int State_Propagating = 2;
	public static final int State_Absorbing = 3;
	public static final int State_Dead = 4;

	public Ray(PVector position, PVector direction, 
		float velocity, float length) {
		this.start = position.copy();
		this.end = position.copy();
		this.direction = direction.copy();
		this.velocity = velocity;
		this.length = length;
	}

	public void update(float dt) {
		if (state == State_Dead) {
			return;
		}
		
		if (state == State_Extending) {
			end.add(vectorVelocity().mult(dt));
			
			if (actualLength() > length) {
				fixLength();
				state = State_Propagating;
			}
			
			return;
		}
		
		if (state == State_Propagating) {
			start.add(vectorVelocity().mult(dt));
			fixLength();
			if (start.mag() > eye.mag()) {
				state = State_Dead;
			}
			return;
		}
		
		if (state == State_Absorbing) {
			return;
		}
	}
	
	public void render() {
		if (state == State_Dead) {
			return;
		}
		drawThickLine(start, end, 10);
	}
	
	float actualLength() {
		return end.copy().sub(start).mag();
	}
	
	PVector vectorVelocity() {
		return direction.copy().mult(velocity);
	}
	
	void fixLength() {
		end = start.copy().add(direction.copy().mult(length));
	}
  
	
}

class Sphere
{
	public PVector center;
	public float radius = 0.0f;
	
	Sphere(PVector center, float radius) {
		this.center = center;
		this.radius = radius;
	}
}
