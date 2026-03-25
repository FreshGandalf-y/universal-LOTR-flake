{ config, pkgs, self, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/darwin/default.nix
    ./packages-casks.nix
  ];

  nix.enable = true;
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  documentation = {
    enable = true;
    man.enable = true;
  };

  environment.loginShellInit = ''
    export PATH="$HOME/.config/emacs/bin:$PATH"
  '';

  #networking
  networking = {
    computerName = "Middle Earth";
    hostName = "Middle-Earth";
    dns = [
      "1.1.1.1"
      "8.8.8.8"
      "2001:4860:4860::8888"
      "2001:4860:4860::8844"
    ];
    knownNetworkServices = [
      "AX88179B"
      "Thunderbolt Bridge"
      "Wi-Fi"
    ];
  };

   services.openssh.enable = true;

    services.tailscale = {
    enable = true;
      package = pkgs.tailscale;
    };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Security
    #security.pam.services.sudo_local.touchIdAuth = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    system.primaryUser = "belalangner";

    system.defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleIconAppearanceTheme = "ClearLight";
        AppleInterfaceStyle = "Dark";
      };
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      dock.autohide = true;
      dock.mru-spaces = false;
      finder.AppleShowAllExtensions = true;
      finder.FXPreferredViewStyle = "clmv";
      finder.ShowPathbar = true;
      loginwindow.LoginwindowText = "this mashine is the nix-darwin system 'Middle-Earth', a property of goonen.org";
      screencapture.location = "~/Pictures/screenshots";
      screensaver.askForPasswordDelay = 10;
    };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.allowed-users = [ "@admin" ];

  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nix.settings = {
    trusted-users = [ "root" "belalangner" ];
  };
}
