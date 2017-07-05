/*

Title: TR707

Author: Jack Mason

Notes:

The aim of this sketch was to recreate a simplified version of Roland's classic TR-707 drum machine.

*/

// Imports libraries that are needed
import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.opengl.*;
import controlP5.*;

// Variables created based on classes from libraries
ControlP5 cp5;
Minim mnm;
AudioOutput masterOut;
Gain gain = new Gain(0.f), 
     ch1  = new Gain(0.f), 
     ch2  = new Gain(0.f), 
     ch3  = new Gain(0.f), 
     ch4  = new Gain(0.f), 
     ch5  = new Gain(0.f), 
     ch6  = new Gain(0.f), 
     ch7  = new Gain(0.f), 
     ch8  = new Gain(0.f), 
     ch9  = new Gain(0.f), 
     ch10 = new Gain(0.f);

void setup()
{
  // Sets size and background colour
  size(800, 400);
  background(tr707grey);
  
  // Assigns this patch to initiated instances.
  // This has to happen in the setup, otherwise
  // the compiler can't patch anything.
  cp5 = new ControlP5(this);
  mnm = new Minim(this);
  masterOut = mnm.getLineOut();
  
  // Runs various setup functions to set up the sketch's
  // relevant control parameters, located in the functions file
  sequencerGenerator();
  controlParameterGenerator();                 
  sampleButtonGenerator();
  volumeSliderGenerator();
}

void draw()
{ 
  // The draw function loops over all functions 
  // inside it continuously. A lot of these keep
  // having to be redrawn as some parameters in
  // the functions reset the background color.
  
  // Function to count the beat 
  beatCounter(); 
  
  // Function to draw the samples names beside the sequencer
  textGen();
  
  // Loads the Roland logo - probably not the most efficient way to do it
  image(loadImage("images/rolandLogo.png"), width/12, 20);
  
  // Draws the sequencer steps to the screen
  seqFiller();
  
  // These draw the division lines to the screen
  line(0, 60, width, 60);
  line(0, 205, width, 205);
}

// Keypressed monitors which keys the user has pressed on the keyboard
void keyPressed() 
{
  // All this does is play a different sample depending on the key that
  // is pressed by the user.
  switch (key)
  {
    case 'q':
      samples[0].trigger();
      break;
    
    case 'w':
      samples[1].trigger();
      break;
    
    case 'e':
      samples[2].trigger();
      break;
      
    case 'r':
      samples[3].trigger();
      break;
      
    case 't':
      samples[4].trigger();
      break;
      
    case 'y':
      samples[5].trigger();
      break;
      
    case 'u':
      samples[6].trigger();
      break;
      
    case 'i':
      samples[7].trigger();
      break;
      
    case 'o':
      samples[8].trigger();
      break;
      
    case 'p':
      samples[9].trigger();
      break;
  }
}

// This function monitors everything the user is doing in the window, 
// and it has cases set up to respond accordingly

void controlEvent(ControlEvent e)
{
  // Gets the ID of the parameter that's being activated
  int controlID = e.getId();
  
  // Gets the value associated with the parameter being activated
  float controllerValue = e.getValue();

  if (controlID < 10) // Sample Buttons
  {
    switch(controlID)
    {
      // These are the switch cases that manages the buttons on the drum machine
      case 0:
        samples[0].trigger();
        break;
        
      case 1:
        samples[1].trigger();
        break;
      
      case 2:
        samples[2].trigger();
        break;
    
      case 3:
        samples[3].trigger();
        break;
        
      case 4:
        samples[4].trigger();
        break;
    
      case 5:
        samples[5].trigger();
        break;
    
      case 6:
        samples[6].trigger();
        break;
        
      case 7:
        samples[7].trigger();
        break;
        
      case 8:
        samples[8].trigger();
        break;
        
      case 9:
        samples[9].trigger();
        break;
    }
  }
  else if (controlID >= 10 && controlID < 20) // Volume Control Variables
  { 
    // These are the cases that manage the individual sample volumes
    switch(controlID)
    {
      case 10: 
        ch1.setValue(controllerValue);
        break;
        
      case 11:
        ch2.setValue(controllerValue);
        break;
      
      case 12:
        ch3.setValue(controllerValue);
        break;
        
      case 13:
        ch4.setValue(controllerValue);
        break;
        
      case 14:
        ch5.setValue(controllerValue);
        break;
        
      case 15:
        ch6.setValue(controllerValue);
        break;
        
      case 16:
        ch7.setValue(controllerValue);
        break;
        
      case 17:
        ch8.setValue(controllerValue);
        break;
        
      case 18:
        ch9.setValue(controllerValue);
        break;
        
      case 19:
        ch10.setValue(controllerValue);
        break;
    }
  }
  else if (controlID >= 50 && controlID < 60) // Master Control Variables
  {
    // These are the cases that manage the master variables
    switch(controlID)
    {
      case 50: // Stop Button
        // This button currently pauses the sequence as opposed to stopping 
        // and restarting it. This could potentially be resolved by resetting
        // the same instrument instance with a zero start time.
        masterOut.pauseNotes();
        seqStopped = true;
        break;
        
      case 51: // Start Button
        // Like with the stop button, this should restart the sequence from 0
        // if the sequence is already playing. A potential resolution could be
        // the resetting of the instrument already playing to a start time of 0.
        masterOut.setTempo( bpm );
        
        // seqStarted keeps track of whether or not a the sequence has already
        // been started, and makes a decision on what to do.
        
        if (seqStarted == false)
        {
          seqStarted = true;
          bpm = 80;
          masterOut.setTempo( bpm );
          masterOut.playNote( 0, 0.25f, new Tick() );
        } 
        else if (seqStarted == true)
        {
          // Attempt to start from 0
          //masterOut.playNote( 0, 0.25f, this );
          masterOut.resumeNotes(); 
        }
        break;
        
      case 52: // Clear Button
        // Attempt to alter saved boolean variables so that the sequencer could be reset.
        // Unfortunately this wasn't completed in time but is something to do for the future.
        cleared = true;
        println(buttons);
        buttons.iterator();
        break;
        
      case 53: // Mute Button
      
        // Tis case mutes the output if the mute button has been selected,
        // or unmutes the output if the mute has already been selected previously.
       
        if (masterOut.isMuted())
        {
          masterOut.unmute();
        }
        else
        {
          masterOut.mute();  
        }
        break;
        
      case 54: // Master Gain
        
        // This paramater, while initialised, is not functional but was intended
        // to control the master gain for the drum machine as a sum of all the 
        // individual channels.
        
        gain.setValue(controllerValue);
        break;
        
      case 55: // 'Fine Tune' Tempo Control 
        // This is a mock fine tune tempo which will be turned into a real fine tempo control.
        bpm = int(controllerValue);
        masterOut.setTempo( bpm );
        break;
        
      case 56: // Standard Tempo Control
        // This is a standard control tempo which sets the tempo to whole numbers
        bpm = int(controllerValue);
        masterOut.setTempo( bpm );
        break;
    } 
  }
}