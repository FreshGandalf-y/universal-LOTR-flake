{ pkgs, lib, config, ... }:

{
  options.modules.darwin.podman = {
    enable = lib.mkEnableOption "podman";
  };

  config = lib.mkIf config.modules.darwin.enable {
    virtualisation.podman = {
      enable = true;
#      dockerSocket.enable = true;
#      dockerCompat = true;
#      autoPrune = {
#        enable = true;
#        dates = "weekly";
#      };
#      networkSocket.enable = false;
#      networkSocket.openFirewall = false;
    };
  };
}
