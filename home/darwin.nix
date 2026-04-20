{ pkgs, user, lib, ... }:

{
  imports = [ ./default.nix ];

  #darwin (macos) specific config here:
  home.homeDirectory =  lib.mkForce "/Users/${user}";
  home.username = user;
}
