{ config, pkgs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/default.nix
    ../../modules/common.nix
    ./packages-casks.nix
  ];

  modules.nixos.podman.enable = true;

  nix.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
