{ config, pkgs, ... }:

{
	users.users = {
		celebrimbor = {
			isNormalUser = true;
			description = "celebrimbor";
			extraGroups = [ "networkmanager" "wheel" "audio" "jackaudio"];
			home = "/home/celebrimbor";
			packages = with pkgs; [
				firefox
				htop
				fastfetch
				hyfetch

        #terminal emulators 
        alacritty

				#devenv 
        devenv

				#Editor
				emacs
				vscode
				ghostty

				#communication
				element-desktop
				signal-desktop

				alsa-scarlett-gui 

			  #desktop
  			papirus-icon-theme
  			sdbus-cpp
				kdePackages.wayland-protocols
				libxkbcommon
        noctalia-shell

				#gnu-stuff
				coreutils
				ripgrep
				fd
				clang
				gnupg

				#vpn
				tailscale

				#education
				texliveFull
				texstudio

				#Images
				gimp2

				#containerisation
				podman
				podman-compose
				podman-desktop
			];
		};

#		environment.shellInit = ''
#  			export PATH="$HOME/.config/emacs/bin:$PATH"
#		'';

		guest = {
			isNormalUser = true;
			description = "Guest";
			extraGroups = [ "networkmanager" ];
			home = "/home/guest";
			packages = with pkgs; [
				firefox
				nautilus
				vscode
				arduino-ide
				libreoffice
			];
		};
	};

	fonts.packages = with pkgs; [
		nerd-fonts.fira-code
		nerd-fonts.symbols-only
		nerd-fonts.iosevka
		nerd-fonts.jetbrains-mono
		nerd-fonts.heavy-data
	];
	

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	environment.systemPackages = with pkgs; [
    pyright
    lua-language-server
    stylua
    yaml-language-server
    gnumake

		vimPlugins.nvim-treesitter.withAllGrammars

  ];

	system.activationScripts.niriSession = ''
		mkdir -p /home/celebrimbor
		echo -e "[Desktop]\nSession=niri" > /home/celebrimbor/.dmrc
		chown celebrimbor:users /home/celebrimbor/.dmrc
	'';

	system.activationScripts.gnomeSession = ''
		mkdir -p /home/guest
		echo -e "[Desktop]\nSession=gnome" > /home/guest/.dmrc
		chown guest:users /home/guest/.dmrc
	'';

}
