class Target
{
  PVector location;
  PVector velocity;
  PVector acceleration;

  float max_force;
  float max_speed;
  float size;
  
  Target(float x, float y, float z)
  {
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    
    size = 12;
    max_force = 0.5;
    max_speed = 8;
  }
  
  void update()
  {
    PVector future = velocity.copy();
    future.normalize();
    future.mult(100);
    future.add(location);

    float angle_1 = random(360);
    float angle_2 = random(360);
    float x = 50 * cos(radians(angle_1)) * sin(radians(angle_2)) + future.x;
    float y = 50 * sin(radians(angle_1)) * sin(radians(angle_2)) + future.y;
    float z = 50 * cos(radians(angle_2)) + future.z;
    
    seek(new PVector(x, y, z));
        
    if(PVector.dist(new PVector(width / 2, height / 2, 0), location) > width / 2) 
    {  
      seek(new PVector(width / 2, height / 2, 0));
    }
    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void seek(PVector target)
  {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();
    if(d < 100)
    {
      float m = map(d, 0, 100, 0, max_speed);
      desired.mult(m);
    }else
    {
      desired.mult(max_speed);
    }
  
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
    
  void display()
  {
    pushMatrix();
    translate(location.x, location.y, location.z);
    noStroke();
    fill(0, 255, 255);
    sphere(size);
    popMatrix();
  }
}