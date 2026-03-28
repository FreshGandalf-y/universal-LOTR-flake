{ pkgs, lib, config, ... }:

{
  options.modules.nixos.podman = {
    enable = lib.mkEnableOption "podman";
  };

  config = lib.mkIf config.modules.nixos.podman.enable {
    virtualisation.podman = {
      enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
      networkSocket.enable = false;
      networkSocket.openFirewall = false;
    };

    users.groups.docker.members =
      builtins.attrNames (lib.filterAttrs
        (_: u: builtins.elem "wheel" u.extraGroups)
        config.users.users);
  };
}
