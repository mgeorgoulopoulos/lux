class Scene
{
  public ArrayList<Ray> rays = new ArrayList<Ray>();
  public ArrayList<Sphere> spheres = new ArrayList<Sphere>();

  public void update(float dt) {
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
}
