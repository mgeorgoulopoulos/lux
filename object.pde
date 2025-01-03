class Ray
{
  public PVector position = new PVector();
  public PVector velocity = new PVector();
  public float length = 0.0;
  
  public Ray(PVector position, PVector velocity, float length) {
    this.position = position;
    this.velocity = velocity;
    this.length = length;
  }
  
  public void update(float dt) {
    position.add(velocity.copy().mult(dt));
    if (position.mag() > eye.mag()) {
      if (velocity.dot(position) > 0) {
        // Going away. Return it
        velocity.mult(-1);
      }
    }
  }
  
  PVector endPoint() {
    return velocity.copy().normalize().mult(length).add(position);
  }
  
  public void render() {
    drawThickLine(position, endPoint(), 10);
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
