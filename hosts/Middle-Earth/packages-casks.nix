{ pkgs, lib, config, nix-darwin, ... }:

{
  environment.systemPackages = with pkgs; [
        #entertainment
        spotify

        #Emacs
        emacs
        symbola

        #networking
        wireshark
        postman
        htop
        btop

        #virtual Mashines
        utm

        #graphics
        #blender # is broken
        #inkscape # is broken

        #fetches
        fastfetch
        hyfetch

        #ditors 
        neovim

        #Browsers
        firefox

        #gnu-stuff
        coreutils
        fd
        ripgrep
        libtool

        #security
        bitwarden-desktop
        yubikey-manager
        pinentry_mac
        gnupg

        #languages
        rustc
        cargo
        rust-analyzer
        clippy
        rustfmt
        clang
        nodejs_24
        pnpm

        #development environment
        #direnv # unkommented becouse broken, installed via homebrew (now with home-manager)
        #emacsPackages.direnv
        #devenv

        #librarys
        libiconv
        glibtool

        #terminal emulator

  ];
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.symbols-only
  ];


  #homebrew
  homebrew = {
    enable = true;
    brews = [
          #frameworks
          "vapor"
        ];
        casks = [
          #editors
          "android-studio"

          #multimedia
          "kdenlive"
          "gimp"
          "obs"
          "inkscape"

          #massenger
          "signal"
          "element"


          #Terminal-Emulator
          "ghostty"

          #Browsers
          "tor-browser"

          #Games
          "supertuxkart"

          #VPN
          "tailscale-app"

          #office
          "libreoffice"

          #graphics
          "blender"

          "obsidian"
    ];
    masApps = {
      "Xcode" = 497799835;
    };
  };
}
