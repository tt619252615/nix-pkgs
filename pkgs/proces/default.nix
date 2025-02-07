{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, }:

buildPythonPackage rec {
  pname = "proces";
  version = "0.1.7";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-cKBdnpc91oX3qQksWL5pWoGBpBHWN5bCEyMv0/3EN3U=";
  };

  buildInputs = [ setuptools wheel ];

  pythonImportsCheck = [ "proces" ];

  meta = {
    description = "Text preprocess";
    homepage = "https://pypi.org/project/proces/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
