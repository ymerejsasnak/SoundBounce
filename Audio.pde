public class Audio
{
  AudioContext ac;
  SamplePlayer[] samples;
  Gain gain;
  int sampleLoadCounter;
  
  boolean loaded;
  
  Sample recordedOutput;
  RecordToSample recorder;
  
  Audio()
  {
    loaded = false;
    sampleLoadCounter = 0;
    ac = new AudioContext();
        
    gain = new Gain(ac, 2, .5);
    samples = new SamplePlayer[4];
    selectInput("choose a sample", "getFile", sketchFile(""), this);
  }
  
  public void getFile(File selection)
  {
    if (selection == null)
    {
      exit();  
    }
    else
    {
      setupSamplers(sampleLoadCounter, selection.getAbsolutePath());
    }
    
  }
  
  
  void setupSamplers(int samplerIndex, String path)
  {
    try {
      samples[samplerIndex] = new SamplePlayer(ac, new Sample(path)); 
    } 
    catch (IOException e) {
      println("load error");
      exit();
    }
  
    gain.addInput(samples[samplerIndex]);
    samples[samplerIndex].pause(true);
    samples[samplerIndex].setKillOnEnd(false);
    samples[samplerIndex].setInterpolationType(SamplePlayer.InterpolationType.CUBIC);
    
    
    if (sampleLoadCounter < 3) {
      sampleLoadCounter++;
      selectInput("choose a sample", "getFile", sketchFile(""), this);
    }
    
    else {
      loaded = true;
      ac.out.addInput(gain);
      recordedOutput = new Sample(100);
      recorder = new RecordToSample(ac, recordedOutput, RecordToSample.Mode.INFINITE);
      recorder.addInput(ac.out);
      recorder.pause(true);
      ac.out.addDependent(recorder);
      ac.start();
    }
  }
  
  
  void trigger(int index, float value)
  {
    if (loaded) {
      samples[index].setRate(new Static(ac, value));
      samples[index].reTrigger();
    }
  }
  
  void recordToFile() {
    if (recorder.isPaused()) {
      println("now recording");
      recorder.pause(false);
    }
    else {
      recorder.pause(true); 
      recorder.clip();
                  //use SelectOutput to save file, not this junk!
      //String saveName = String.valueOf(year() + month() + day() + hour() + minute() + second() + millis());
      try {
        recordedOutput.write(dataPath("temp.wav"), AudioFileType.WAV);
        println("file saved");
      }
      catch (IOException e) {
        println("couldn't save");
      }
      recordedOutput = new Sample(100);
      recorder.setSample(recordedOutput);
      recorder.reset();
    }
  }
  
  
}