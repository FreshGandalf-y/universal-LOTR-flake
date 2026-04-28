{ pkgs, inputs, lib, config, ... }:
{
  programs.fuzzel.enable = true;
  programs.swaylock.enable = true;
  services.mako.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;

  home = {
    stateVersion = "26.05";
    packages = [
      pkgs.swaybg
      pkgs.xwayland-satellite
      pkgs.noctalia-shell
      pkgs.niri
    ];
    sessionVariables = {
      DOOMDIR = "$HOME/.config/doom/";
    };
  };
}
