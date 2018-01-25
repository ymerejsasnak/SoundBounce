public class Audio
{
  AudioContext ac;
  SamplePlayer sampler;
  Gain gain;
  Envelope gainEnv;
  
  Audio()
  {
    ac = new AudioContext();
    ac.start();
    gainEnv = new Envelope(ac);
    
    gain = new Gain(ac, 2, gainEnv);
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
      setupSampler(selection.getAbsolutePath());
    }
    
  }
  
  
  void setupSampler(String path)
  {
    try
    {
      sampler = new SamplePlayer(ac, new Sample(path)); 
    }
    catch (IOException e)
    {
       println("load error");
       exit();
    }
    
    gain.addInput(sampler);
    ac.out.addInput(gain);
    //sampler.pause(true);
    sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    sampler.setInterpolationType(SamplePlayer.InterpolationType.CUBIC);
   
  }
  
  
  void triggerReverse(int y)
  {
    zeroEnvelope();
    float rate = map(y, height - BORDER, BORDER, -.75, -1.5);    
    sampler.setRate(new Static(ac, rate));
    gainEnv.addSegment(1, 10);
    gainEnv.addSegment(0, 10000/ball.speed);
    //sampler.setToEnd();
    //sampler.start();
  }
  
  void triggerForward(int y)
  {
    zeroEnvelope();
    float rate = map(y, height - BORDER, BORDER, .75, 1.5);   
    sampler.setRate(new Static(ac, rate));
     gainEnv.addSegment(1, 10);
    gainEnv.addSegment(0, 10000/ball.speed);
    //sampler.setToLoopStart();
    //sampler.start();
  }
  
  
  void zeroEnvelope()
  {
    gainEnv.setValue(0); 
  }
}