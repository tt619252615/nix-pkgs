{ lib, buildPythonPackage, fetchPypi, setuptools, furo, olefile, sphinx
, sphinx-copybutton, sphinx-inline-tabs, sphinxext-opengraph, check-manifest
, coverage, defusedxml, markdown2, packaging, pyroma, pytest, pytest-cov
, pytest-timeout, trove-classifiers, typing-extensions, }:

let
  url =
    "https://files.pythonhosted.org/packages/d4/2c/668e18e5521e46eb9667b09e501d8e07049eb5bfe39d56be0724a43117e6/pillow-11.1.0-cp310-cp310-manylinux_2_17_aarch64.manylinux2014_aarch64.whl";
in buildPythonPackage rec {
  pname = "pillow";
  version = "11.1.0";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:1qnf1xxyab8dyrmahvqfaizjshw4fixas596df0j8a72ql2blzd0";
  };

  buildInputs = [ setuptools ];

  meta = {
    description = "Python Imaging Library (Fork)";
    homepage = "https://pypi.org/project/pillow/";
    license = lib.licenses.unfree; # FIXME: 请根据实际情况设置许可证
    maintainers = with lib.maintainers; [ ];
  };
}
