{ lib, buildPythonPackage, fetchFromGitHub, setuptools, wheel, packaging
, typeguard, }:

buildPythonPackage rec {
  pname = "addons";
  version = "0.23.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "tensorflow";
    repo = "addons";
    rev = "v${version}";
    hash = "sha256-2tIZsbB33JlSlvJ2QcE1s6l+G0NYt37V+nVII64qduQ=";
  };

  build-system = [ setuptools wheel ];

  dependencies = [ packaging typeguard ];

  pythonImportsCheck = [ "addons" ];

  meta = {
    description =
      "Useful extra functionality for TensorFlow 2.x maintained by SIG-addons";
    homepage = "https://github.com/tensorflow/addons";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
