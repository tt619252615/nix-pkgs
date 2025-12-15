{ lib, buildPythonPackage, fetchPypi, setuptools, }:

let
  url =
    "https://files.pythonhosted.org/packages/1c/b5/8ea29a8f8293c0b2145ae53817309cc59f3779cdde2945e2f2e5670bc225/nmslib-2.1.2-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.whl";

in buildPythonPackage rec {
  pname = "nmslib";
  version = "2.1.2";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:17fd53crxx56p30ld8dkk7wqy4hbr7rj8wjc2il6xry81nk8rwcc";
  };

  buildInputs = [ setuptools ];

  meta = {
    description = "Nearest Neighbor Search Library";
    homepage = "https://pypi.org/project/nmslib/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
