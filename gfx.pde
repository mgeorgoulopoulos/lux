void drawThickLine(PVector p1, PVector p2, float thickness) {
  PVector direction = p2.copy().sub(p1).normalize();
  PVector center = p2.copy().add(p1).mult(0.5);
  PVector lookAt = center.copy().sub(eye).normalize();
  PVector up = lookAt.cross(direction).normalize().mult(0.5f * thickness);
  
  PVector a = p1.copy().add(up);
  PVector b = p2.copy().add(up);
  PVector c = p2.copy().sub(up);
  PVector d = p1.copy().sub(up);
  
  beginShape(QUADS);
  vertex(a);
  vertex(b);
  vertex(c);
  vertex(d);
  endShape();
}

void drawArc(PVector startPoint, PVector center, PVector right, float thickness) {
  int segmentCount = 20;
  
  // Create half a circle of points
  PVector halfCircle[] = new PVector[segmentCount];
  for (int i=0; i<segmentCount; i++) {
    float angle = i * (PI / (segmentCount - 1));
    halfCircle[i] = new PVector(cos(angle), sin(angle), 0);
  }
  
  // Make coordinate system
  PVector up = center.copy().sub(startPoint).normalize();
  PVector look = right.cross(up);
  
  //  Scale coords by radius
  float radius = center.copy().sub(startPoint).mag();
  up.mult(radius);
  look.mult(radius);
  
  // Transform the points to that space
  for (PVector p : halfCircle) {
  
    p.set(look.copy().mult(p.y).add(up.copy().mult(p.x)).add(center));
  }
  
  beginShape(QUAD_STRIP);
  for (int i=0; i<segmentCount; i++) {
    PVector sideA = right.copy().mult(thickness).add(halfCircle[i]);
    PVector sideB = right.copy().mult(-thickness).add(halfCircle[i]);
    
    vertex(sideA); 
    vertex(sideB);
  }
  endShape();

}

void vertex(PVector v) {
  vertex(v.x, v.y, v.z);
}

void line(PVector a, PVector b)
{
	line(a.x, a.y, a.z, b.x, b.y, b.z);
}

void tesselateGeoTriangle(PVector a, PVector b, PVector c, int iterations)
{
	if (iterations <= 0) {
		line(a, b);
		line(b, c);
		line(c, a);
		return;
	}
	
	// Recurse
	PVector a2 = a.copy().add(b).mult(0.5f).normalize();
	PVector b2 = b.copy().add(c).mult(0.5f).normalize();
	PVector c2 = c.copy().add(a).mult(0.5f).normalize();
	
	tesselateGeoTriangle(a, a2, c2, iterations - 1);
	tesselateGeoTriangle(c, c2, b2, iterations - 1);
	tesselateGeoTriangle(a2, b, b2, iterations - 1);
	tesselateGeoTriangle(a2, b2, c2, iterations - 1);
}

void drawGeosphere(int iterations)
{
	// Regular tetrahedron centered at the origin
	PVector a = new PVector(1, 1, 1).normalize();
	PVector b = new PVector(1, -1, -1).normalize();
	PVector c = new PVector(-1, 1, -1).normalize();
	PVector d = new PVector(-1, -1, 1).normalize();
	
	tesselateGeoTriangle(a, b, c, iterations);
	tesselateGeoTriangle(b, c, d, iterations);
	tesselateGeoTriangle(c, d, a, iterations);
	tesselateGeoTriangle(d, a, b, iterations);
}

void drawWireSphere(PVector center, float radius) {
	 
  strokeWeight(2.0f / radius);
  
  pushMatrix();
  translate(center.x, center.y, center.z);
  scale(radius);
  drawGeosphere(4);
  popMatrix();
}
