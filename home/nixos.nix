{ pkgs,inputs, lib, config, ... }: 

{
  programs.fuzzel.enable = true; # Super+D in the default setting (app launcher)
  programs.swaylock.enable = true; # Super+Alt+L in the default setting (screen locker)
  services.mako.enable = true; # notification daemon
  services.swayidle.enable = true; # idle management daemon
  services.polkit-gnome.enable = true; # polkit

  home = {
    stateVersion = "26.05";
    packages = [
      pkgs.swaybg # wallpaper
      pkgs.xwayland-satellite # xwayland support
      (inputs."wrapper-modules".wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
      })
    ];
  };
}
