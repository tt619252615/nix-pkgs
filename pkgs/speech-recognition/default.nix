{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, audioop-lts
, standard-aifc, typing-extensions, requests, pyaudio, numpy, pytest
, pytest-randomly, respx, faster-whisper, google-cloud-speech, groq, httpx
, openai, pocketsphinx, openai-whisper, soundfile, }:

buildPythonPackage rec {
  pname = "speech-recognition";
  version = "3.14.1";
  pyproject = true;

  src = fetchPypi {
    pname = "speechrecognition";
    inherit version;
    hash = "sha256-x2f4VY4RGmXppWkFsE6uwjMfh9UBE3k4FiH0et7WxP4=";
  };

  buildInputs = [ setuptools wheel pocketsphinx ];

  pythonImportsCheck = [ "speech_recognition" ];

  meta = {
    description =
      "Library for performing speech recognition, with support for several engines and APIs, online and offline";
    homepage = "https://pypi.org/project/SpeechRecognition/";
    license = with lib.licenses; [ gpl2Only bsd3 bsd2 ];
    maintainers = with lib.maintainers; [ ];
  };
}
