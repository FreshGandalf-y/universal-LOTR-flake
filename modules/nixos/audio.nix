{ config, pkgs, lib, ... }:

let
  #audio user
  audiouser = "celebrimbor";
in
{
	security.rtkit.enable = true;
  services.avahi.enable = true; 

  services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	  jack.enable = true;

    extraConfig.pipewire = {
      "context.propperties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 2048;
      };
    };

		#AirPlay / Roap configuration:
		#raopOpenFirewall = true;
		#extraConfig.pipewire = {
		#	"10-Airplay" = {
		#		"context.modules" = [
		#			{
		#				name = "libpipewire-module-roap-discover";
		#				args = {
		#					"roap.latency.ms" = 500;
		#				};
		#			}
		#		];
		#	};
		#};
	};

  users.users.${audiouser} = {
      extraGroups = [ "audio" "jackaudio" ];
  };

  security.pam.loginLimits = [
      { domain = "@auio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@auio"; item = "rtprio"; type = "-"; value = "99"; }
      { domain = "@auio"; item = "nofile"; type = "soft"; value = "99999"; }
      { domain = "@auio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  environment.systemPackages = with pkgs; [
    pipewire
	  pipewire.jack

    # DAW and plugin host
    ardour
    carla

	  # Plugins (VL2, ... ) 
	  surge-XT
	  noise-repellent

    # Audio routing and monitoring
    qjackctl    # Jack patchbay (works with pipewire)
    #helvum      # Native PipeWire patchbay
    qpwgraph    # Qt-based PipeWire graph manager 

    # Utilities
    pavucontrol # PulseAudio volume control (works with pipewire)
    pulsemixer  # Terminal-based mixer
	  alsa-scarlett-gui
  ];
	

  services.pulseaudio.enable = false;
	
  # intel-interface-driver
  boot.kernelModules = [ "snd-hda-intel" ];
	hardware.enableAllFirmware = true;
  }
