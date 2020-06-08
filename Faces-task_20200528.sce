scenario = "Faces-task_20200528.sce";
pcl_file = "Faces-task_20200528.pcl";

#scenario_type = fMRI_emulation;
scenario_type = fMRI;
pulse_code = 23;
pulses_per_scan = 1;
scan_period=2000;

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
default_all_responses = false;

response_logging = log_all;
response_matching = simple_matching;

begin;

$nr_faces = 36 ; 
$nr_scrambled = 72 ; 

array {
	LOOP $female_nr '$nr_faces';
		$pic = '$female_nr + 1';
		bitmap { filename = "female ($pic).jpg"; preload = true;
					height = 10;
					scale_factor = scale_to_height; 
					};
	ENDLOOP;
	LOOP $male_nr '$nr_faces';
		$pic = '$male_nr + 1';
		bitmap { filename = "male ($pic).jpg"; preload = true;
					height = 10;
					scale_factor = scale_to_height; 
					};
	ENDLOOP;
} face_array;

array {
LOOP $pic_nr '$nr_scrambled';
	$pic = '$pic_nr + 1';
	bitmap { filename = "scrambled ($pic).jpg"; preload = true;
				height = 10;
				scale_factor = scale_to_height; 
				};
ENDLOOP;
} scrambled_array;
	
text { caption = "+"; description = "5"; } plus;
picture { text plus; x=0; y=0; } fixcross;

trial {
	picture { text { caption = "Gleich geht's los"; }; x = 0; y = 0; }; # Enter text to inform participant that the experiment is about to start
	code = "prepare";
} prepare;

bitmap { filename = "female (1).jpg"; preload = true;
			height = 10;
			scale_factor = scale_to_height; 
			} placeholder;

trial {
	trial_type = fixed;
	all_responses = true;
	stimulus_event {
      picture { bitmap placeholder; x = 0; y = 0; } mpb_pic1;
      time = 0;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 3000;
		} mpb_event1;
	stimulus_event {
      picture { bitmap placeholder; x = 0; y = 0; } mpb_pic2;
      deltat = 3000;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 3000;
		} mpb_event2;
   stimulus_event {
      picture { bitmap placeholder; x = 0; y = 0; } mpb_pic3;
      deltat = 3000;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 3000;
		} mpb_event3;
	stimulus_event {
      picture { bitmap placeholder; x = 0; y = 0; } mpb_pic4;
      deltat = 3000;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 3000;
		} mpb_event4;
	stimulus_event {
      picture { bitmap placeholder; x = 0; y = 0; } mpb_pic5;
      deltat = 3000;
		duration = next_picture;
		stimulus_time_in = 0;
		stimulus_time_out = 3000;
		} mpb_event5;
	stimulus_event {
      picture { bitmap placeholder; x = 0; y = 0; } mpb_pic6;
      deltat = 3000;
		duration = 3000;
		stimulus_time_in = 0;
		stimulus_time_out = 3000;
		} mpb_event6;
} mpb_trial; # multiple picture block - trial

trial {
	trial_type = fixed;
	stimulus_event {
		picture fixcross;
		time = 0;
		duration = next_picture; 
		code = "rest";
	} fixcross_event;
} fixcross_trial;


trial {
	trial_duration = 4000;
	stimulus_event {		
		picture { text { caption = "Ende"; }; x = 0; y = 0; }; # "End of experiment"
		deltat = 2000;
		code = "end";
	};
} end_trial;