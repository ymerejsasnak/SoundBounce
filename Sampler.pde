
public class Sampler {
  
  AudioContext audioContext;
  
  SamplePlayer[] players;
  Envelope[] envelopes;
  Gain[] gains;
  
  boolean hasSample;
  
  int currentVoice = 0;
  int lastVoice = -1;
  final int MAX_VOICES = 4;
  
  String sampleName;

  
  
  Sampler(AudioContext ac) {
    audioContext = ac;
    hasSample = false;    
    sampleName = "none";
    players = new SamplePlayer[MAX_VOICES];
    envelopes = new Envelope[MAX_VOICES];
    gains = new Gain[MAX_VOICES];
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
      for (int i = 0; i < MAX_VOICES; i++) {
        if (hasSample) {
          players[i].kill();
        }
        players[i] = new SamplePlayer(audio.ac, new Sample(sampleFile.getAbsolutePath()));
      }
      sampleName = sampleFile.getName();
      println(sampleFile.getName() + " loaded successfully");
      setupSampler();
    } 
    catch (IOException e) {
      println(sampleFile.getName() + " is not a valid file.");
    }
    
  }
  
  
  void setupSampler() {
    for (int i = 0; i < MAX_VOICES; i++) {
      
      envelopes[i] = new Envelope(audioContext, 1);
      gains[i] = new Gain(audioContext, 2, envelopes[i]);
      gains[i].addInput(players[i]);
      audio.gain.addInput(gains[i]);
      
      players[i].pause(true);
      players[i].setKillOnEnd(false);
      players[i].setInterpolationType(SamplePlayer.InterpolationType.CUBIC);
      
    }
    hasSample = true; 
  }
  
  
  void trigger(float rate) {
    if (hasSample) {
      envelopes[currentVoice].setValue(1);
      
      players[currentVoice].setRate(new Static(audio.ac, rate));
      players[currentVoice].reTrigger();
      
      if (lastVoice >= 0) {
        envelopes[lastVoice].addSegment(0, 100);
      }
      
      lastVoice = currentVoice;
      currentVoice = (currentVoice + 1) % MAX_VOICES;
    }
  }
  
  
  String getSampleName() {
    return sampleName;
  }
  
}