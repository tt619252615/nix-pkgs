{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, aiohttp, certifi, srt
, tabulate, typing-extensions, black, isort, mypy, pylint, types-tabulate, }:

buildPythonPackage rec {
  pname = "edge-tts";
  version = "7.0.0";
  pyproject = true;

  src = fetchPypi {
    pname = "edge_tts";
    inherit version;
    hash = "sha256-vV2wwFu3/Zczl5IvcPyDcce+K7SRH5w4vTjBTte1Ki0=";
  };

  buildInputs =
    [ setuptools wheel aiohttp certifi srt tabulate typing-extensions ];

  dependencies = [ aiohttp certifi srt tabulate typing-extensions ];

  pythonImportsCheck = [ "edge_tts" ];

  meta = {
    description = "Microsoft Edge's TTS";
    homepage = "https://pypi.org/project/edge-tts/";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
  };
}
