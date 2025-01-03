Scene scene = new Scene();

PVector eye = new PVector(0, 0, 200);

int prevTime = 0;

void setup() {
  size(1920, 1080, P3D);

  // Init rays
  randomSeed(42);
  for (int i=0; i<100; i++) {
    scene.rays.add(new Ray(randomPoint(random(100, 200)), randomDirection().mult(random(200, 400)), random(400, 500)));
  }

  for (int i=-2; i<=2; i++) {
    for (int j=-2; j<=2; j++) {
      for (int k=-2; k<=2; k++) {
        scene.spheres.add(new Sphere(new PVector(i, j, k).add(randomPoint(0.4)).mult(50.0f), 15.0f));
      }
    }
  }
  scene.spheres.add(new Sphere(new PVector(-50, -50, -50), 40));
  scene.spheres.add(new Sphere(new PVector(50, 50, 50), 40));

  prevTime = millis();
}

void draw() {
  background(0);
  blendMode(ADD);
  hint(DISABLE_DEPTH_TEST);
  noLights();


  int newTime = millis();
  float deltaTime = (newTime - prevTime) / 1000.0f;
  prevTime = newTime;
  float time = newTime / 1000.0f;

  scene.update(deltaTime);

  // Move camera
  eye = new PVector(sin(0.1 * time), 0, cos(0.1 * time)).mult(200.0f);

  resetMatrix();
  camera(eye.x, eye.y, eye.z, 0, 0, 0, 0, 1, 0);

  scene.render();

  noStroke();
  int arcCount = 8;
  for (int i=0; i<arcCount; i++) {
    float angle = i * 2.0f * PI / (arcCount - 1);
    angle += time;
    drawArc(new PVector(0, -2000, 0), new PVector(0, 0, 0), new PVector(sin(angle), 0, cos(angle)), 15);
  }

  PVector center = new PVector(0, 0, 0);
  float radius = 200.0f;



  //drawWireSphere(center, radius);
}
