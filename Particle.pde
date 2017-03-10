class Particle
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  PVector[] history;
  
  float max_force;
  float max_speed;
  float size;
  color body_color;
  int len;
  float a_span;
  
  Particle(float x, float y, float z)
  {
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    
    len = 10;
    history = new PVector[len];
    for(int i = 0; i < history.length; i++)
    {
      history[i] = location.copy();
    }
    
    size = 20;
    max_force = 0.5;
    max_speed = 12;
    body_color = color(random(255), 255, 255);
    a_span = 255 / len;
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
    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0);
    
    for(int i = history.length - 1; i > 0; i--)
    {
      history[i] = history[i - 1].copy();
    }
    history[0] = location.copy();
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
    for(int i = 0; i < history.length; i++)
    {
      pushMatrix();
      translate(history[i].x, history[i].y, history[i].z);
      stroke(body_color, 255 - a_span * i);
      strokeWeight(1);
      //noFill();
      fill(body_color, 200 - a_span * i);
      box(size - i * 2);
      popMatrix();
    }
  }
}