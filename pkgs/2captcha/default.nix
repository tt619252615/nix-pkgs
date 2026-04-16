{ lib, buildPythonPackage, fetchurl, aiofiles, httpx, pythonOlder, requests, setuptools }:

buildPythonPackage rec {
  pname = "2captcha-python";
  version = "2.0.6";
  format = "setuptools";

  src = fetchurl {
    url =
      "https://files.pythonhosted.org/packages/b0/39/40aac4ccfdb1e6a40f83d473a885741f546b45e49c0daa7673df30ddd2d9/2captcha_python-${version}.tar.gz";
    hash = "sha256-nlaxYWx7dDbvhH9CobEatTOSFD3EFgH0qXnkVMW/v8s=";
  };

  disabled = pythonOlder "3.8";
  doCheck = false;

  propagatedBuildInputs = [ aiofiles httpx requests ];
  nativeBuildInputs = [ setuptools ];

  pythonImportsCheck = [ "twocaptcha" ];

  meta = with lib; {
    description = "Python module for easy integration with 2Captcha API";
    homepage = "https://pypi.org/project/2captcha-python/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
