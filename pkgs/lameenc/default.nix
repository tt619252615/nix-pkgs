{ lib, buildPythonPackage, fetchFromGitHub, setuptools, setuptools-scm, wheel
, autoPatchelfHook, cmake }:

buildPythonPackage rec {
  pname = "lameenc";
  version = "1.8.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "chrisstaite";
    repo = "lameenc";
    rev = "v${version}";
    hash = "sha256-/GV18mPcru1raFfFQGSAHgNwpmwN4oVFKcBL4JjZkC8=";
  };

  buildInputs = [ setuptools setuptools-scm wheel ];
  nativeBuildInputs = [ autoPatchelfHook cmake ];
  meta = {
    description = "Python bindings around the LAME encoder";
    homepage = "https://github.com/chrisstaite/lameenc";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ ];
  };
}
