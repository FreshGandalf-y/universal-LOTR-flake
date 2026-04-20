{ pkgs, ... }: {
  home.stateVersion = "25.11";

  # your dotfiles, shell config, etc.
  programs.git = {
    enable = true;
    userName = "FreshGandalf-y";
    userEmail = "belajohanlangner@gmail.com";
  };
}
