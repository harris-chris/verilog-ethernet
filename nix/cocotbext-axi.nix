 {
  lib,
  python,
  fetchFromGitHub,
}:

python.pkgs.buildPythonPackage rec {
  pname = "cocotbext-axi";
  version = "0.1.24";
  format = "setuptools";

  # pypi source doesn't include tests
  src = fetchFromGitHub {
    owner = "alexforencich";
    repo = "cocotbext-axi";
    rev = "refs/tags/v${version}";
    hash = "sha256-/OBFezpsmWQyCPuYs/3Yan9v9GrQ5wvEw4PU6pLugkI=";
  };

  nativeBuildInputs = [ python.pkgs.setuptools-scm ];

  buildInputs = [ python.pkgs.setuptools ];
  propagatedBuildInputs = [ python.pkgs.find-libpython ];
}
