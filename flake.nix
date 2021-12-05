{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/desktop/configuration.nix
          ./hosts/desktop/hardware-configuration.nix
        ];
      };
  };
}
