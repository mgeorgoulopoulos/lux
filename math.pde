PVector randomPoint(float extent)
{
  return new PVector(random(-1, 1), random(-1,1), random(-1,1)).mult(extent);
}

PVector randomDirection()
{
  return randomPoint(1).normalize();
}

