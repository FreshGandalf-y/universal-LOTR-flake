{ pkgs, ... }: 

{
  environment.systemPackages = with pkgs; [
 
    #programming languages
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
    clang
    cmake
    nodejs_24
    pnpm

    #emacs
    symbola
    emacsPackages.vterm
  ];
}
