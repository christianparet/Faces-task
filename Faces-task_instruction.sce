############## Slide show for instructions #################################
# Subject can switch forward and backward through the instruction slides
# After Trial 9 there is an example experiment

#################### Information on settings and files #####################
# Three buttons need to be defined: button 1 = left, label = "yes"; button 2 = right, label = "no"; button 3 = bottom button on pad (requires no label)
# Make a subdirectory in the stimuli directory called "instruction"
# Make instruction slides ("slide1.png", "slide2.png",...), put them into the instruction-folder and change variables "$nr_slides" (sce-part) and "nr_of_instructionslides" (pcl-part; see below) according to nr of slides
# Put demo-pictures ("demopic1_negative.jpg", "demopic2_negative.jpg", demopic3_negative.jpg"; same for scrambled) to the instruction-folder
############################################################################ 

default_background_color = 75,75,75;
default_text_color = 255,255,255;
default_text_align = align_center;
default_font = "Arial";
default_font_size = 0.8; # with definition of screen parameters, font size is relative to user defined units

screen_width_distance = 40; 
screen_height_distance = 11;
max_y = 5.5;

active_buttons = 2;   
button_codes = 1,2;
default_all_responses = true;

response_matching = simple_matching;

$nr_slides = 2 ; # Total number of instruction slides

begin;

array {
	LOOP $pic_nr '$nr_slides';
		$pic = '$pic_nr + 1';
		bitmap { filename = "instruction\\faces_slide$pic.jpg"; preload = true;
				height = 10;
				scale_factor = scale_to_height;
				};
	ENDLOOP;
} slide_array;

trial {                                  
    trial_type = first_response;     
		picture { bitmap { filename = "instruction\\faces_slide1.jpg"; 
				height = 10;
				scale_factor = scale_to_height;
								}; x=0; y=0; 
					} slide_pic;
		time = 0;
		duration = response;
} slide_trial; 

trial {
	trial_type = fixed;
	all_responses = true;
	stimulus_event {
      picture { bitmap { filename = "instruction\\demopic1_faces.jpg"; 
				height = 10; 
				scale_factor = scale_to_height;
								}; x = 0; y = 0; 
					};
      time = 0;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 6000;
		target_button = "male"; # "male"/"female"; indicate whether there is a male or female on demopic1
   };
	stimulus_event {
      picture { bitmap { filename = "instruction\\demopic2_faces.jpg"; 
				height = 10;
				scale_factor = scale_to_height; 
								}; x = 0; y = 0; 
					};
      deltat = 6000;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 6000;
		target_button = "female"; # "male"/"female"; indicate whether there is a male or female on demopic2
   };
   	stimulus_event {
      picture { bitmap { filename = "instruction\\demopic3_faces.jpg"; 
				height = 10;
				scale_factor = scale_to_height; 
								}; x = 0; y = 0; 
					};
      deltat = 6000;
		duration = 6000;
		stimulus_time_in = 0;
		stimulus_time_out = 6000;
		target_button = "male"; # "male"/"female"; indicate whether there is a male or female on demopic3
   };
} test_trial_negative;

trial {
	trial_type = fixed;
	all_responses = true;
	stimulus_event {
      picture { bitmap { filename = "instruction\\scrambled1_faces.jpg"; 
				height = 10;
				scale_factor = scale_to_height; 
								}; x = 0; y = 0; 
					};
      time = 0;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 6000;
		target_button = "male"; 
   };
	stimulus_event {
      picture { bitmap { filename = "instruction\\scrambled2_faces.jpg"; 
				height = 10;
				scale_factor = scale_to_height; 
								}; x = 0; y = 0; 
					};
      deltat = 6000;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 6000;
		target_button = "male"; 
   };
   	stimulus_event {
      picture { bitmap { filename = "instruction\\scrambled3_faces.jpg"; 
				height = 10;
				scale_factor = scale_to_height; 
								}; x = 0; y = 0; 
					};
      deltat = 6000;
		duration = 6000;
		stimulus_time_in = 0;
		stimulus_time_out = 6000;
		target_button = "female"; 
   };
} test_trial_scrambled;

text { caption = "+"; description = "5"; } plus;

trial {
	trial_type = fixed;
	picture { text plus; x=0; y=0; };
} rest;

begin_pcl;

int slide_nr=1;
int nr_of_instructionslides=2; # Enter here number of slides; you may specify an additional final slide shown after the example experiment (see below). If this is the case, indicate here number of last slice to be shown before example experiment
int goforwardorbackward;

loop until slide_nr>nr_of_instructionslides begin
	
	slide_pic.set_part(1,slide_array[slide_nr]);
	
	goforwardorbackward=0;
	
	slide_trial.present();
	if response_manager.last_response()==2 then
		goforwardorbackward=-1;
	elseif response_manager.last_response()==1 then
		goforwardorbackward=1;
	end;
	
	if (slide_nr==1 && goforwardorbackward==-1) || slide_nr>nr_of_instructionslides then
	else
		slide_nr=slide_nr+goforwardorbackward;
	end;
	
end;

rest.set_duration(2000);
rest.present();

test_trial_negative.present();
term.print("hits: "+string(response_manager.hits())+", misses: "+string(response_manager.misses())+"\n");	

rest.set_duration(10000);

test_trial_scrambled.present();
term.print("hits: "+string(response_manager.hits())+", misses: "+string(response_manager.misses())+"\n");

#instr_pic.set_part(1,instr_array[slide_nr]); # Comment out to present final slide after example experiment
#instr_trial.present();