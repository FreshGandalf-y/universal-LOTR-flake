{ pkgs, lib, config, ... }:
{
  options.modules.darwin.podman = {
    enable = lib.mkEnableOption "podman";
  };
  config = lib.mkIf config.modules.darwin.podman.enable {
    environment.systemPackages = with pkgs; [
      podman
      podman-desktop
    ];
  };
}
