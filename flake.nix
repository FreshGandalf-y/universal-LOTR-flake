{
  description = "multi-usable flake for LOTR systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }: 
  let
    mkNixos = system: hostname: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ] ++ extraModules;
      };

    mkDarwin = system: hostname: extraModules:
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit self; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ] ++ extraModules;
      };
  in
  {
    # NixOS machines
    nixosConfigurations = {
      Valinor = mkNixos "x86_64-linux" "Valinor" [];
      server  = mkNixos "aarch64-linux" "server" [];
    };

    # darwin machines
    darwinConfigurations = {
      Middle-Earth = mkDarwin "aarch64-darwin" "Middle-Earth" [];
    };
  };
}
