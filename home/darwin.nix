{ pkgs, user, lib, ... }:

{
  imports = [ ./default.nix ];

  #darwin (macos) specific config here:
  home.homeDirectory =  lib.mkForce "/Users/${user}";
  home.username = user;

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };
}
