{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, }:

buildPythonPackage rec {
  pname = "r-pi-gpio";
  version = "0.7.1";
  pyproject = true;

  src = fetchPypi {
    pname = "RPi.GPIO";
    inherit version;
    hash = "sha256-zWHEsDw3tiu6SlrP6phidJwzxhjgKV5+kKpHE/s3O3A=";
  };

  buildInputs = [ setuptools wheel ];

  #   pythonImportsCheck = [ "r_pi_gpio" ];

  meta = {
    description = "A module to control Raspberry Pi GPIO channels";
    homepage = "https://pypi.org/project/RPi.GPIO/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
