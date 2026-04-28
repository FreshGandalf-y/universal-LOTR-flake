{ pkgs, ... }: {
  home.stateVersion = "25.11";

  # your dotfiles, shell config, etc.
  programs.git = {
    enable = true;
    settings.user = {
      init.defaultBranch = "main";

      name = "FreshGandalf-y";
      email = "belajohanlangner@gmail.com";
    };
  };
}
