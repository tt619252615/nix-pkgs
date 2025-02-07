{ lib, buildPythonPackage, fetchPypi, setuptools, }:

buildPythonPackage rec {
  pname = "standard-chunk";
  version = "3.12.2";
  pyproject = true;

  src = fetchPypi {
    pname = "standard_chunk";
    inherit version;
    hash = "sha256-iOQZ99DIpWMPXY1fssBNrHuWVkYNo0NvaAQ6s6/qmaA=";
  };

  buildInputs = [ setuptools ];

  #   pythonImportsCheck = [ "standard_chunk" ];

  meta = {
    description = ''Standard library chunk redistribution. "dead battery'';
    homepage = "https://pypi.org/project/standard-chunk/";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
  };
}
