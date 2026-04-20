{
  description = "multi-usable flake for LOTR systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
  let
    mkNixos = system: hostname: user: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self inputs; user = user; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; user = user; };
            home-manager.users.${user} = import ./home/nixos.nix;
          }
        ] ++ extraModules;
      };

    mkDarwin = system: hostname: user: extraModules:
      nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit self; user = user; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; user = user; };
            home-manager.users.${user} = import ./home/darwin.nix;
          }
        ] ++ extraModules;
      };
  in
  {
    # NixOS machines
    nixosConfigurations = {
      Valinor = mkNixos "x86_64-linux" "Valinor" "celebrimbor" [];
      server  = mkNixos "x86_64-linux" "server" "" [];
    };

    # darwin machines
    darwinConfigurations = {
      "Middle-Earth" = mkDarwin "aarch64-darwin" "Middle-Earth" "belalangner" [];
    };
  };
}
