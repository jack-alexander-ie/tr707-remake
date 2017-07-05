/* 
      MASTER CONTROL PARAMS

  These are the parameters that will be used for the master controls of the patch.
  
  Various classes are called to do tasks, including the Slider, Knob and Button classes.

  Intergers and booleans are created here to monitor overall changes, and will be changed
  depending on the functions that use them.
  
  The numberbox is used to control the standard master tempo.

*/

Button stopButton, startButton, clearButton, muteButton;
Slider masterVolume;

Knob tempoKnob;
Slider masterVol;

int bpm;
int beat; // which beat we're on
String beatCounter;

// These interger will be used for the start/stop sequence
boolean seqStarted = false;
boolean seqStopped = false;

Numberbox tempoControl;