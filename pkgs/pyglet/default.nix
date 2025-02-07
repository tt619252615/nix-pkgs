{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, }:

buildPythonPackage rec {
  pname = "pyglet";
  version = "1.5.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bqkYmF/t36m/D8wB/+n/WEnntugy2bLgO50qNjactu4=";
    extension = "zip";
  };

  buildInputs = [ setuptools wheel ];

  pythonImportsCheck = [ "pyglet" ];

  meta = {
    description = "Pyglet is a cross-platform games and multimedia package";
    homepage = "https://pypi.org/project/pyglet/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
  };
}
