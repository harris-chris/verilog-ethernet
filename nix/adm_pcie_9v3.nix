{ lib, stdenv, gnumake, python, verilog, cocotb-test, cocotbext-eth, cocotbext-axi, build10g ? false }:

let 
  thisPython = python.withPackages (ps: 
    [ ps.cocotb ps.scapy ps.cocotb-bus ps.pytest cocotb-test cocotbext-eth cocotbext-axi ]
  );
in
  stdenv.mkDerivation rec {
    name = "adm_pcie_9v3";

    buildInputs = [ gnumake thisPython verilog ];

    src = lib.cleanSource ../.;

    patchPhase = if build10g 
      then 
        ''
        cd example/ADM_PCIE_9V3/fpga_25g
        substituteInPlace Makefile \
              --replace-quiet "SUBDIRS = fpga\n" "SUBDIRS = fpga_10g\n"
        ''
      else 
        ''
        cd example/ADM_PCIE_9V3/fpga_25g
        substituteInPlace Makefile \
              --replace-quiet "SUBDIRS = fpga_10g\n" "SUBDIRS = fpga\n"
        '';

    buildPhase = ''
      make
    '';
  }
