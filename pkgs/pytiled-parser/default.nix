{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, attrs
, typing-extensions, build, black, furo, mypy, myst-parser, pytest, pytest-cov
, ruff, sphinx, sphinx-sitemap, zstd, }:

let
  url =
    "https://files.pythonhosted.org/packages/d7/f7/6b6c51b50ed8681a31146e5e7ac325b78fe776ff48b1ec8f56d7e4995d72/pytiled_parser-2.2.9-py2.py3-none-any.whl";
in buildPythonPackage rec {
  pname = "pytiled-parser";
  version = "2.2.9";
  format = "wheel";
  src = builtins.fetchurl {
    inherit url;
    sha256 = "sha256:148zbypq086x45l8g3ldvja53i93c4yrz9dxwcpd1x0bjlqkvxrp";
  };

  buildInputs = [ setuptools wheel attrs typing-extensions ];

  meta = {
    description = "A library for parsing Tiled Map Editor maps and tilesets";
    homepage = "https://pypi.org/project/pytiled-parser/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
