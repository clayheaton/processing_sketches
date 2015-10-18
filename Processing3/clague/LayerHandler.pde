class LayerHandler {
  ArrayList<Layer> layers;

  LayerHandler() {
    layers = new ArrayList<Layer>();
  }

  void createBackgroundLayerWith(JSONObject _bgData) {
    BackgroundLayer bgLayer = new BackgroundLayer(_bgData);
    layers.add(bgLayer);
  }

  void displayLayers() {
    for (Layer l : layers) {
      l.display();
    }
  }
}