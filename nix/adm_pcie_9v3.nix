{ lib, stdenv, gnumake, python311, python311Packages, build10g ? false }:

let 
  thisPython = python311.withPackages (ps: [ ps.cocotb ]);
in
  stdenv.mkDerivation rec {
    name = "adm_pcie_9v3";

    buildInputs = [ gnumake thisPython ];

    src = lib.cleanSource ../.;

    patchPhase = if build10g 
      then 
        ''
        cd example/ADM_PCIE_9V3/fpga_25g
        substituteInPlace Makefile \
              --replace-fail "SUBDIRS = fpga" "SUBDIRS = fpga_10g"
        ''
      else 
        ''
        cd example/ADM_PCIE_9V3/fpga_25g
        '';

    buildPhase = ''
      make
    '';
  }
