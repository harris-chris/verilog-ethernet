{
  description = "verilog-ethernet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self
    , nixpkgs
  }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ thisOverlay ];
      };
      inherit (pkgs) lib;

      thisOverlay = self: super: rec { 
        python = super.python312;
        cocotb-test = with super; callPackage ./nix/cocotb-test.nix { inherit python; };
        cocotbext-axi = with super; callPackage ./nix/cocotbext-axi.nix { inherit python; };
        cocotbext-eth = with super; callPackage ./nix/cocotbext-eth.nix { inherit python; };
      };
    in
    {
      packages.${system} = {
        adm_pcie_9v3_10g = with pkgs; callPackage ./nix/adm_pcie_9v3.nix { build10g = true; };
        adm_pcie_9v3_25g = with pkgs; callPackage ./nix/adm_pcie_9v3.nix { };
        inherit (pkgs) cocotb-test cocotbext-eth cocotbext-axi;
      };
    };
}
