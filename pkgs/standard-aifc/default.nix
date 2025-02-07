{ lib, buildPythonPackage, fetchPypi, setuptools, audioop-lts, standard-chunk,
}:

buildPythonPackage rec {
  pname = "standard-aifc";
  version = "3.13.0";
  pyproject = true;

  src = fetchPypi {
    pname = "standard_aifc";
    inherit version;
    hash = "sha256-ZOJJx8tLPa8v26TpVyH4Eb3ovfxDrZ+TZYm3uy+uLkM=";
  };

  buildInputs = [ setuptools ];

  dependencies = [ audioop-lts standard-chunk ];

  #   pythonImportsCheck = [ "standard_aifc" ];

  meta = {
    description = ''Standard library aifc redistribution. "dead battery'';
    homepage = "https://pypi.org/project/standard-aifc/";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
  };
}
