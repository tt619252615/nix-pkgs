{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, numpy, cython, pytest,
}:

buildPythonPackage rec {
  pname = "cylimiter";
  version = "0.4.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-U6/MOoFD86DP14Kz1hz0OI5u1q5XVVfkwgzgQL9Zbbc=";
  };

  buildInputs = [ setuptools wheel numpy ];

  #   dependencies = [ numpy ];

  #   optional-dependencies = { dev = [ cython pytest ]; };

  pythonImportsCheck = [ "cylimiter" ];

  meta = {
    description = "Audio limiter in Cython";
    homepage = "https://pypi.org/project/cylimiter/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };
}
