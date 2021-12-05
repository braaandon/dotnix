{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home }: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
 
          home.nixosModule {
            home-manager = {
              useGlobalPkgs = true;
              users.brandon = import ./home/brandon;
            };
          } 
        ];
      };
  };
}
