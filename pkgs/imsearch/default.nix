{ lib, buildPythonPackage, fetchPypi, setuptools, furo, olefile, sphinx
, sphinx-copybutton, sphinx-inline-tabs, sphinxext-opengraph, check-manifest
, coverage, defusedxml, markdown2, packaging, pyroma, pytest, pytest-cov
, pytest-timeout, trove-classifiers, typing-extensions, }:

let
  url =
    "https://files.pythonhosted.org/packages/ab/d3/506a772b7bec7c0346db7fc862eefb97bc1bd031ec73c54df5d6579a9c28/imsearch-0.1.1-py3-none-any.whl";

in buildPythonPackage rec {
  pname = "imsearch";
  version = "0.1.1";
  format = "wheel";

  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:001vckr6ln7kvgqrk8nw47mpslj9498hq4c7xs0r47dgv14z66c1";
  };

  buildInputs = [ setuptools ];

  meta = {
    description = "Image search engine";
    homepage = "https://pypi.org/project/imsearch/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
