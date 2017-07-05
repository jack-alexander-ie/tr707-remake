void sampleButtonGenerator()
{
  
  // This function generates everything related to the samples
  // and their control.
  
  // A counter used to pass file names into the sampler,
  // and also to set them in array index positions.
  int initCount = 0;

  // Iterates over the number of values in the samples array and adds them to it.
  // It looks for the sample listed in the first parameter, assigns it 4 voices 
  // and connects it to the minim system
  for (Sampler sample : samples)
  {  
    samples[initCount] = new Sampler( "samples/SAMPLE_" + initCount + ".wav", 4, mnm );
    initCount++;
  }
  
  // These patch each of the samples to their own channel, which are in turn patched to the master output
  samples[0].patch( ch1 ).patch( masterOut );
  samples[1].patch( ch2 ).patch( masterOut );
  samples[2].patch( ch3 ).patch( masterOut );
  samples[3].patch( ch4 ).patch( masterOut );
  samples[4].patch( ch5 ).patch( masterOut );
  samples[5].patch( ch6 ).patch( masterOut );
  samples[6].patch( ch7 ).patch( masterOut );
  samples[7].patch( ch8 ).patch( masterOut );
  samples[8].patch( ch9 ).patch( masterOut );
  samples[9].patch( ch10 ).patch( masterOut );
  
  /*
   This is alternative code that was used to 
   attempt to make a master gain.
  
    samples[0].patch( ch1 ).patch( gain );
    samples[1].patch( ch2 ).patch( gain );
    samples[2].patch( ch3 ).patch( gain );
    samples[3].patch( ch4 ).patch( gain );
    samples[4].patch( ch5 ).patch( gain );
    samples[5].patch( ch6 ).patch( gain );
    samples[6].patch( ch7 ).patch( gain );
    samples[7].patch( ch8 ).patch( gain );
    samples[8].patch( ch9 ).patch( gain );
    samples[9].patch( ch10 ).patch( gain );
    
    gain.patch(masterOut);
    
  */
  
  /* 
  
    Below here are a number of buttons that will be used to launch individual
    instances of the samples. They each have their own id so that, when clicked,
    the switch statement looking after control events with be able to determine 
    what to do.
    
    The range of Id's they're given go from 0 to 9.
  
  */
  
  kickButton  = cp5.addButton("KD")
                     .setPosition(width/6, sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(0)
                           .setColorBackground(tr707black);
                  
  snareButton = cp5.addButton("HH")
                     .setPosition(width/6 + buttonSeparator, sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(1)
                           .setColorBackground(tr707black);
  
  ltmButton  = cp5.addButton("LTM")
                     .setPosition(width/6 + (buttonSeparator*2), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(2)
                           .setColorBackground(tr707black);
                  
  mtmButton = cp5.addButton("MTM")
                     .setPosition(width/6 + (buttonSeparator*3), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(3)
                           .setColorBackground(tr707black);
                           
  htmButton = cp5.addButton("HTM")
                     .setPosition(width/6 + (buttonSeparator*4), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(4)
                           .setColorBackground(tr707black);

  rimButton = cp5.addButton("RIM")
                     .setPosition(width/6 + (buttonSeparator*5), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(5)
                           .setColorBackground(tr707black);
  
  cowButton = cp5.addButton("COW")
                     .setPosition(width/6 + (buttonSeparator*6), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(6)
                           .setColorBackground(tr707black);
  
  clpButton = cp5.addButton("CLP")
                     .setPosition(width/6 + (buttonSeparator*7), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(7)
                           .setColorBackground(tr707black);
  
  tamButton = cp5.addButton("TAM")
                     .setPosition(width/6 + (buttonSeparator*8), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(8)
                           .setColorBackground(tr707black);
  
  hatButton   = cp5.addButton("SD")
                     .setPosition(width/6 + (buttonSeparator*9), sampleYPos)
                       .setSize(buttonXSize,buttonYSize)
                         .setId(9)
                           .setColorBackground(tr707black);
}

void volumeSliderGenerator()
{
  // Volume Sliders, given ID numbers: 10 - 19
  sliderWidth = 30;
  sliders = new Slider[nSliders];
  
  // Multiple by which i will be multiplied to separate the volume faders
  int xPos = 0;
  
  String channelNames[] = {"KD", "HH", "LTM", "MTM", "HTM", "RIM", "COW", "CLP", "TAM", "SD", "Crash"};
  
  /* 
  
    Below is a for loop that interates over a slider generated as many times as there has been
    sliders defined by nSliders i.e. the number of sliders that will be needed. Each channel is
    given its own id that is dependent on the value in the channelNames array. For example, if
    if a slider is created at index 0 in the sliders array, it will be given an name of "KD" + "CH"
    because that is the string value that matches that same index position in the channelName array.
    "CH" is added so that there is no confusion between the channels having the same names as the buttons,
    yet maintains consistency in the layout and naming. It then positions the sliders x position based on
    a multiple of the first sliders x position. 
    
    They are then assigned an id in the range between 10 and 20 so it's easy to keep track of what ID controls
    which parameter.
  
  */
  
  for (int i = 0; i < nSliders; i++)
  {
    sliders[i] = cp5.addSlider(channelNames[i] + " ")
                      .setId(i + 10)
                        .setSize(sliderWidth - (2 * hPad), 90)
                          .setPosition((width/2) + (sliderWidth * xPos), 100)
                            .setRange(-24, 0)
                              .setColorBackground(tr707black)
                                .setColorForeground(tr707orange)
                                  .setColorActive(tr707orange)
                                    .setValue(-12);
    
    xPos = xPos + 1;  
  }
  
}

void controlParameterGenerator()
{ 
  
  /* 
  
    This section generates the control parameters for the sketch. There are a combination
    of knobs and sliders, each of which are given their own ID in the range 50 to 60 for
    easy tracking.
  
  */
  
  stopButton   = cp5.addButton("STOP")
                      .setPosition(width/12, topYPos+60)
                        .setSize(buttonXSize,buttonYSize)
                          .setId(50)
                            .setColorBackground(tr707black);
                  
  startButton  = cp5.addButton("START")
                      .setPosition(width/12, middleYPos+20)
                        .setSize(buttonXSize,buttonYSize)
                          .setId(51)
                            .setColorBackground(tr707black);
                   
  clearButton  = cp5.addButton("CLEAR")
                      .setPosition(width/12, sampleYPos)
                        .setSize(buttonXSize,buttonYSize)
                          .setId(52)
                            .setColorBackground(tr707black);
                   
  muteButton   = cp5.addButton("MUTE")
                      .setPosition(width - 85, sampleYPos)
                        .setSize(buttonXSize,buttonYSize)
                          .setId(53)
                            .setColorBackground(tr707black)
                              .setColorActive(tr707orange);
                  
  masterVol    = cp5.addSlider("Master")
                      .setId(54)
                        .setSize(30, 90)
                          .setPosition(width - 85, 100)
                            .setRange(-24, 0)
                              .update()
                                .setColorBackground(tr707black)
                                  .setColorForeground(tr707orange)
                                    .setColorActive(tr707orange);
  
  tempoKnob    = cp5.addKnob("Fine Tune Tempo")
                      .setId(55)
                        .setSize(60, height - 250)
                          .setPosition(width - 100, middleYPos-50)
                            .setRange(80, 140)
                              .setColorBackground(tr707black)
                                .setColorForeground(tr707orange)
                                  .setColorActive(tr707orange)
                                    .setTickMarkLength(10)
                                      .setDragDirection(Knob.VERTICAL); 
  
  tempoControl = cp5.addNumberbox("SET TEMPO")
                      .setSize(100, 20)
                        .setPosition(width - 120, middleYPos+40)
                          .setValue(bpm)
                            .setId(56)
                              .setColorBackground(tr707black)
                                .setColorForeground(tr707orange)
                                  .setColorActive(tr707orange)
                                    .setRange(80, 140);

}

/*

 This function generates the rows that will be added to the sketch
 for use in the sequencer. They call the StepSeq class and pass in 
 the relevant arguements that are necessary to generate the rows.

*/

void sequencerGenerator()
{
  for (int i = 0; i < 16; i++)
  {
    buttons.add( new SeqStep(width/6+i*15, 75, kikRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 87, snrRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 99, ltmRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 111, mtmRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 123, htmRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 135, rimRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 147, cowRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 159, hclRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 171, tamRow, i ) );
    buttons.add( new SeqStep(width/6+i*15, 183, hatRow, i ) );
  }
}

// This is a simple function for counting what beat the sequencer is on.

void beatCounter()
{
  switch(beat)
  {
    case 0:
      beatCounter = "1";
      break;
      
    case 4:
      beatCounter = "2";
      break;
      
    case 8:
      beatCounter = "3";
      break;
      
    case 12:
      beatCounter = "4";
      break; 
  }
  background(tr707grey);
  textSize(10);
  fill(0);
  text("Beat Counter: " + beatCounter + "/4", width-402, 80);
};

void seqFiller()
{  
  // This function continues to draw the sequencer to the page
  // when it's called
  for(int i = 0; i < buttons.size(); ++i)
  {
    buttons.get(i).draw();
  } 
}

// This function generates the names for the channels in the step sequencer,
// and also redraws the main name of the drum machine. If this sequence isn't
// run repeatedly, much of the text disapears as other functions reset the background.

void textGen()
{
  for (String sampleName : sampleNames)
  {
    textSize(8);
    fill(tr707black);
    switch (sampleName)
    {
      case "Kick":
        text("Kick", width/12, 80);
        break;
        
      case "Snare":
        text("Snare", width/12, 186);
        break;
        
     case "Low Tom":
        text("Low Tom", width/12, 102);
        break;
        
     case "Mid Tom":
        text("Mid Tom", width/12, 114);
        break;
        
     case "High Tom":
        text("High Tom", width/12, 126);
        break;
        
     case "Rimshot":
        text("Rimshot", width/12, 138);
        break;
        
     case "Cowbell":
        text("Cowbell", width/12, 150);
        break;
        
     case "Clap":
        text("Clap", width/12, 162);
        break;
        
     case "HiHat":
        text("HiHat", width/12, 92);
        break;
        
     case "Tambourine":
        text("Tambourine", width/12, 174); 
        break;
    } 
  }
  
  textSize(16);
  fill(tr707black);
  text("RHYTHM COMPOSER", width-350, 50);
  
  textSize(30);
  fill(tr707black);
  text("TR-707SV", width-180, 50);
}