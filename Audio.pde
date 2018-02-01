class Audio {
  
  AudioContext ac;
  Sampler[] samplers;
  Gain gain;
   
  Sample recordedOutput;
  RecordToSample recorder;
  
  float rateBase = 1;
  float rateRange = 0;
  
  final float RATE_BASE_MIN = 0.1;
  final float RATE_BASE_MAX = 4;
  final float RATE_RANGE_MIN = 0;
  final float RATE_RANGE_MAX = 2;
  
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
    samplers[index].trigger(map(value, POS_MIN, POS_MAX, rateBase, rateBase + rateRange));
  }

  
  void adjustRateBase(float amount) {
    rateBase += amount; 
    rateBase = constrain(rateBase, RATE_BASE_MIN, RATE_BASE_MAX);
    println("Minimum playback rate set to: " + rateBase);
  }
  
  
  void adjustRateRange(float amount) {
    rateRange += amount; 
    rateRange = constrain(rateRange, RATE_RANGE_MIN, RATE_RANGE_MAX);
    println("Maximum playback rate set to: " + rateBase + rateRange);
  }
  
  
  float getRateMin() {
    return rateBase;
  }
  
  
  float getRateMax() {
    return rateBase + rateRange; 
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
  
  
  String getSampleName(int index) {
    return samplers[index].getSampleName();
  }
  
}