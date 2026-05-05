{ pkgs, ... }: {
  home.stateVersion = "26.05";

  # your dotfiles, shell config, etc.
  programs.git = {
    enable = true;
    settings.user = {
      init.defaultBranch = "main";
      commit.gpgsign = true;
      gpg.program = "gpg";

      user.signingkey = "8AA2B24C209F4F0D";
      name = "FreshGandalf-y";
      email = "belajohanlangner@gmail.com";
    };
  };
}
