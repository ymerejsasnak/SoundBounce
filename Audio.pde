class Audio {
  
  AudioContext ac;
  Sampler[] samplers;
  Gain gain;
   
  Sample recordedOutput;
  RecordToSample recorder;
  
  String lastSelectedFolder;
  
  
  Audio() {
    lastSelectedFolder = sketchPath("");
    
    ac = new AudioContext();
        
    gain = new Gain(ac, 2, .5);
    
    samplers = new Sampler[] {new Sampler(), new Sampler(), new Sampler(), new Sampler()};
    
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
    samplers[index].trigger(map(value, POS_MIN, POS_MAX, RATE_MIN, RATE_MAX));
  }

  
  void recordToFile() {
    if (recorder.isPaused()) {
      println("NOW RECORDING");
      recorder.pause(false);
    }
    else {
      recorder.pause(true); 
      recorder.clip();
                  //use SelectOutput to save file, not this junk!
      //String saveName = String.valueOf(year() + month() + day() + hour() + minute() + second() + millis());
      try {
        recordedOutput.write(dataPath("temp.wav"), AudioFileType.WAV);
        println("recording stopped, file saved");
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