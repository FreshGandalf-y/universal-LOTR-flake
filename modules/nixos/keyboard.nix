{ pkgs, ... }:

{
	# Apple keyboard Driver
	boot.kernelModules = [ "hid-apple" ];

	# function keys
	boot.extraModprobeConfig = ''
		options hid_apple fnmode=1
		options hid_apple iso_layout=1
		options hid_apple swap_opt_cmd=0
	'';

	#services.udev.extraRules = ''
	#	ACTION=="add", SUBSYSTEM=="input", ATTRS{idVendor}=="05ac", \
	#	RUN+="${pkgs.bash}/bin/bash -c 'echo 1 > /sys/module/hid_apple/parameters/fnmode'"
	#	ACTION=="add", SUBSYSTEM=="leds", KERNEL=="smc::kbd_backlight", \
	#	Run+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/leds/%k/brightness"
	#'';

	# xkb base layout 
	services.xserver.xkb = {
		layout = "de";
		options = "caps:enable";
	};


	users.users.celebrimbor.extraGroups = [ "video" ];

	services.keyd.keyboards = {
		enable = true;
		apple = {
			ids = [ "05ac:*" ];
			settings = {
				main = {
					f1 = "brightnessdown";
					f2 = "brightnessup";
					f3 = "scale";
					f4 = "search";
					f5 = "kbdillumdown";
					f6 = "kbdillumup";
					f7 = "previoussong";
					f8 = "playpause";
					f9 = "nextsong";
					f10 = "mute";
					f11 = "volumedown";
					f12 = "volumeup";
				};
			};
		};
	};

	environment.systemPackages = with pkgs; [
		brightnessctl
		keyd
		playerctl
	];
}
