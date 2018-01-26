
public class Sampler {
  
  SamplePlayer player;
  boolean hasSample;

  
  Sampler() {
    hasSample = false;    
  }
  
  
  public void selectFile() {
    selectInput("load a file", "getFile", sketchFile(audio.getLastFolder()), this); 
  }
  
  
  public void getFile(File selection) {
    if (selection == null) {
      println("nothing selected");  
    } else {
      loadSample(selection.getAbsoluteFile());
      audio.setLastFolder(selection.getAbsolutePath());
    }
    
  }
  
  
  void loadSample(File sampleFile) {
    try {
      player = new SamplePlayer(audio.ac, new Sample(sampleFile.getAbsolutePath())); 
      audio.gain.addInput(player);
      player.pause(true);
      player.setKillOnEnd(false);
      player.setInterpolationType(SamplePlayer.InterpolationType.CUBIC);
      hasSample = true;
      println(sampleFile.getName() + " loaded successfully");
    } 
    catch (IOException e) {
      println(sampleFile.getName() + " is not a valid file.");
    }
    
  }
  
  
  void trigger(float rate) {
    if (hasSample) {
      player.setRate(new Static(audio.ac, rate));
      player.reTrigger();
    }
  }
  
}