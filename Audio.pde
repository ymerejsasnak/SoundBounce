class Audio {
  
  AudioContext ac;
  Sampler[] samplers;
  Gain gain;
   
  Sample recordedOutput;
  RecordToSample recorder;
  
  float rateMin = 1;
  float rateMax = 1;
  
  String lastSelectedFolder;
  
  
  Audio() {
    lastSelectedFolder = sketchPath("");
    
    ac = new AudioContext();
        
    gain = new Gain(ac, 2, .5);
    
    samplers = new Sampler[] {new Sampler(ac), new Sampler(ac), new Sampler(ac), new Sampler(ac)};
    
    ac.out.addInput(gain);
    
    recordedOutput = new Sample(100);
    recorder = new RecordToSample(ac, recordedOutput, RecordToSample.Mode.INFINITE);
    recorder.addInput(ac.out);
    recorder.pause(true);
    ac.out.addDependent(recorder);
    
    ac.start();   
  }
  
  
  void setLastFolder(String path) {
    lastSelectedFolder = path; 
  }
  
  
  String getLastFolder() {
    return lastSelectedFolder;  
  }
  
  
  void loadSample(int index) {
    samplers[index].selectFile(); 
  }
  
  
  void triggerSampler(int index, float value) {
    samplers[index].trigger(map(value, POS_MIN, POS_MAX, rateMin, rateMax));
  }

  
  void adjustRateMin(float amount) {
    rateMin += amount; 
    rateMin = constrain(rateMin, RATE_MIN, 1);
    println("Minimum playback rate set to: " + rateMin);
  }
  
  
  void adjustRateMax(float amount) {
    rateMax += amount; 
    rateMax = constrain(rateMax, 1, RATE_MAX);
    println("Maximum playback rate set to: " + rateMax);
  }

  void recordToggle() {
    if (recorder.isPaused()) {
      println("BEGIN RECORDING");
      recorder.pause(false);
    } else {
      println("END RECORDING");
      recorder.pause(true); 
      recorder.clip();
      
      recordToFile(); 
    }
  }
  
  
  void recordToFile() {    
    int saveNumber = new File(dataPath("")).listFiles().length; 
    String saveName = "BallBounceRecording" + saveNumber + ".wav";
    
    try {
      recordedOutput.write(dataPath(saveName), AudioFileType.WAV);
      println("File \"" + saveName + "\" saved to data folder.");
    } catch (IOException e) {
      println("Couldn't save recording (check for existence of data folder).");
    }
    
    resetRecorder();  
  }
  
  
  void resetRecorder() {
    recordedOutput = new Sample(100);
    recorder.setSample(recordedOutput);
    recorder.reset(); 
  }
  
}