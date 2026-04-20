  { config, pkgs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default.nix
    ../../modules/common.nix
    ../../modules/nixos/niri.nix
    ./packages-casks.nix
    ./users.nix
  ];

  modules.nixos.podman.enable = true;

  nix.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "valinor";
  # networking.wireless.enable = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver.enable = true;

  # Gnome and gdm
  services.displayManager = {
	  gdm.enable = true;
	  gdm.wayland = true;
  };
  services.desktopManager.gnome.enable = true;

  networking.networkmanager.enable = true;

  # Enabling Broadcom firmware blobs 
  boot.kernelModules = ["wl" "broadcom_sta"];  

  nixpkgs.config.permittedInsecurePackages = [
	"broadcom-sta-6.30.223.271-59-6.12.64"
  ];

  services.udisks2.enable = true;

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	vim
  	wget
  	git
	  kitty

	  #linuxKernel.packages.linux_xanmod_latest.broadcom_sta
	  #b43Firmware_6_30_163_46
	  nettools
	  networkmanagerapplet
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.blueman.enable = true;
  hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
	settings = {
		General = {
			Experimental = true;
			FastConnectable = true;
		};
		Policy = {
			AutoEnable = true;
		};
	};
  };

  services.openssh.enable = true;
}
