/* 
      SEQUENCER PARAMS

  The boolean arrays are used by the step sequencer to 'remember' which samples to play and
  which to not.

  The Tick class the timing in the patch, and plays the notes in the sequencer that are filled,
  and is dependant on the boolean sample arrays that have been defined. If a value in the selected
  array is true, lets say the kikRow for example, the kick sample will be triggered. Samples are only
  triggered if a 'true' is returned, acting like a note on message. If a sample is unfilled, the
  opposite happens, as the if statement does not resolve to 'true', but resets the beat instead.
  
  The SeqStep class is used to fill and unfill the sequencer.
  
  The mousepressed function monitors what step has been clicked makes sure that step/button's id is 
  gotten and filled or unfilled.
  
  This code was first found at: https://github.com/ddf/Minim/blob/master/examples/Advanced/DrumMachine/DrumMachine.pde
  
  It was altered to suit the needs of the assignment.

*/

boolean cleared = false;

// Rows for the sequencer
boolean[] kikRow = new boolean[16];
boolean[] snrRow = new boolean[16];
boolean[] ltmRow = new boolean[16];
boolean[] mtmRow = new boolean[16];
boolean[] htmRow = new boolean[16];
boolean[] rimRow = new boolean[16];
boolean[] cowRow = new boolean[16];
boolean[] hclRow = new boolean[16];
boolean[] tamRow = new boolean[16];
boolean[] hatRow = new boolean[16];

class Tick implements Instrument
{
  void noteOn( float dur )
  {
    if ( kikRow[beat] ) samples[0].trigger();
    if ( snrRow[beat] ) samples[1].trigger();
    if ( ltmRow[beat] ) samples[2].trigger();
    if ( mtmRow[beat] ) samples[3].trigger();
    if ( htmRow[beat] ) samples[4].trigger();
    if ( rimRow[beat] ) samples[5].trigger();
    if ( cowRow[beat] ) samples[6].trigger();
    if ( hclRow[beat] ) samples[7].trigger();
    if ( tamRow[beat] ) samples[8].trigger();
    if ( hatRow[beat] ) samples[9].trigger();  
  }
  void noteOff()
  {
    // the next beat in the sequencer
    beat = (beat+1)%16;
    
    // resets the tempo to the new tempo
    masterOut.setTempo( bpm );
    
    // replay the same onstance of the instrument
    masterOut.playNote( 0, 0.25f, this );
  }
}

ArrayList<SeqStep> buttons = new ArrayList<SeqStep>();

class SeqStep 
{
  int x, y, w, h;
  boolean[] steps;
  int stepId;
  
  public SeqStep(int _x, int _y, boolean[] _steps, int _id)
  {
    x = _x;
    y = _y;
    w = 10;
    h = 10;
    steps = _steps;
    stepId = _id;
  }
  
  public void draw()
  { 
    if ( steps[stepId] )
    {
      fill(tr707black);
    }
    else
    {
      fill(tr707grey);
    }
    
    ellipse(x,y,w,h);
  }
  
  public void mousePressed()
  {
    if ( mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h )
    {
      cleared = false;
      steps[stepId] = !steps[stepId];
    }
  }
}
void mousePressed()
{
  // Gets the button value of the sequencer
  // so it can be filled when clicked
  for(int i = 0; i < buttons.size(); ++i)
  {
    buttons.get(i).mousePressed();
  }
}