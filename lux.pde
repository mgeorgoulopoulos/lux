Scene scene = new Scene();

PVector eye = new PVector(0, 0, 200);

int prevTime = 0;

void setup() {
	size(1920, 1080, P3D);

	randomSeed(42);

	for (int i=-2; i<=2; i++) {
		for (int j=-2; j<=2; j++) {
			for (int k=-2; k<=2; k++) {
				//scene.spheres.add(new Sphere(new PVector(i, j, k).add(randomPoint(0.4)).mult(50.0f), 15.0f));
			}
		}
	}
	scene.spheres.add(new Sphere(new PVector(0, 50, 50), 40));
	scene.spheres.add(new Sphere(new PVector(-50, -50, 50), 40));
	scene.spheres.add(new Sphere(new PVector(50, -50, 50), 40));

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
}

void mousePressed() {
	scene.fireRandomRay();
}
