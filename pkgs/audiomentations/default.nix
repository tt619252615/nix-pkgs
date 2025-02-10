{ lib, buildPythonPackage, fetchPypi, setuptools, wheel, librosa, numpy
, numpy-minmax, numpy-rms, scipy, soxr, cylimiter, lameenc, pydub, pyloudnorm
, pyroomacoustics, }:

buildPythonPackage rec {
  pname = "audiomentations";
  version = "0.38.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-mEzJqL2naV6xh6x/91traE6mGTaBLT3cluvyJbPbvYM=";
  };

  build-system = [ setuptools wheel ];

  dependencies = [ librosa numpy numpy-minmax numpy-rms scipy soxr ];

  optional-dependencies = {
    extras = [ cylimiter lameenc pydub pyloudnorm pyroomacoustics ];
  };

  pythonImportsCheck = [ "audiomentations" ];

  meta = {
    description =
      "A Python library for audio data augmentation. Inspired by albumentations. Useful for machine learning";
    homepage = "https://pypi.org/project/audiomentations";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
  };
}
