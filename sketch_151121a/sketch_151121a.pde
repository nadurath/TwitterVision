UnfoldingMap map;

void setup()
{
  size(800,600);
  map = new UnfoldingMap(this);
  MapUtils.createDefaultEventDispatcher(this,map);
}

void draw()
{
  map.draw();
}