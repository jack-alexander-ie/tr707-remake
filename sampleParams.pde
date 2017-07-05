/* 
      SAMPLE PARAMS
      
    These are the sample variables that will be used by some of the functions 
    to generate the buttons, sounds and names.
    
    New variable names are initialised from the Button and Sampler classes, and arrays
    are initialised for use generating names and instances of sound.
    
*/
  
Button kickButton, snareButton, ltmButton, mtmButton, htmButton, rimButton, cowButton, clpButton, tamButton, hatButton;
Sampler[] samples = new Sampler[10];
String sampleNames[] = {"Kick", "Snare", "Low Tom", "Mid Tom", "High Tom", "Rimshot", "Cowbell", "Clap", "Tambourine", "HiHat"};