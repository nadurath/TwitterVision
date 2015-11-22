import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;

UnfoldingMap map;

void setup()
{
  size(800,600);
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  MapUtils.createDefaultEventDispatcher(this,map);
}

void draw()
{
  map.draw();
}

void mouseClicked()
{
map.zoomAndPanTo(new Location(52.5f, 13.4f), 10);
}