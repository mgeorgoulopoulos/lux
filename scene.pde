import java.util.Collections;

final float RAY_VELOCITY = 100;
final float RAY_LENGTH = 100;

class Scene
{
  public ArrayList<Ray> rays = new ArrayList<Ray>();
  public ArrayList<Sphere> spheres = new ArrayList<Sphere>();

  public void update(float dt) {
	// cleanup
	rays.removeIf(r -> r.state == Ray.State_Dead);
	
    for (Ray ray : rays) {
      ray.update(dt);
    }
  }

  public void render() {
    fill(10, 20, 100);

    for (Ray ray : rays) {
      ray.render();
    }

    stroke(255, 255, 255);
    for (Sphere sphere : spheres) {
      drawWireSphere(sphere.center, sphere.radius);
    }
  }
  
	public void fireRandomRay() {
		if (spheres.size() <= 0) {
			return;
		}
		
		// Get random sphere
		Sphere sphereA = spheres.get((int)random(spheres.size()));
		Sphere sphereB = secondClosest(sphereA.center);
		
		PVector direction = sphereB.center.copy().sub(sphereA.center).normalize();
		PVector position = sphereA.center.copy().add(direction.copy().mult(sphereA.radius));
		Ray ray = new Ray(position, direction, RAY_VELOCITY, RAY_LENGTH);
		rays.add(ray);
	}
	
	Sphere secondClosest(PVector position) {
		if (spheres.size() < 2) {
			return null;
		}
		ArrayList<Sphere> sortedSpheres = new ArrayList<Sphere>(spheres);
		Collections.sort(sortedSpheres, (a, b) -> {
			return position.copy().sub(a.center).mag() < 
				position.copy().sub(b.center).mag() ? 
					-1 : 1;
		});
		
		return sortedSpheres.get(1);
	}
}









