 {
  lib,
  python,
  fetchFromGitHub,
}:

python.pkgs.buildPythonPackage rec {
  pname = "cocotbext-eth";
  version = "0.1.22";
  format = "setuptools";

  # pypi source doesn't include tests
  src = fetchFromGitHub {
    owner = "alexforencich";
    repo = "cocotbext-eth";
    rev = "refs/tags/v${version}";
    hash = "sha256-5RKXXlaD1tT+IePShrUT8basEfl7vg0XBF8dEUL2wBc=";
  };

  nativeBuildInputs = [ python.pkgs.setuptools-scm ];

  buildInputs = [ python.pkgs.setuptools ];
  propagatedBuildInputs = [ python.pkgs.find-libpython ];
}
