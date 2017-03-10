ArrayList<Particle> particles;
Target _target;

void setup()
{
  size(512, 512, P3D);
  frameRate(30);
  colorMode(HSB);
  blendMode(ADD);
  
  particles = new ArrayList<Particle>();
  
  for(int i = 0; i < 64; i++)
  {
    particles.add(new Particle(random(width), random(height), random(-256, 256)));
  }
  
  _target = new Target(0, 0, 0);
}

void draw()
{
  background(0);
  
  stroke(255);
  strokeWeight(30);
  line(width / 4, 0, 0, width / 4, height , 0);
  line(width / 4 * 3, 0, 0, width / 4 * 3, height , 0);
  line(0, height / 4, 0, width, height / 4, 0);
  line(0, height / 4 * 3, 0, width, height / 4 * 3, 0);
      
  _target.update();
  _target.display();
    
  for(Particle p : particles)
  {
    PVector target = _target.location.copy();
    float angle_1 = random(360);
    float angle_2 = random(360);
    float x = 150 * cos(radians(angle_1)) * sin(radians(angle_2));
    float y = 150 * sin(radians(angle_1)) * sin(radians(angle_2));
    float z = 150 * cos(radians(angle_2));
    target.add(x, y, z);
    
    p.seek(target);
    p.update();
    p.display();
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 900)
  {
     exit();
  }
  */
}