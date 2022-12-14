{ lib
, buildPythonPackage
, fetchFromGitHub
, requests
, requests-oauthlib
, pythonOlder
}:

buildPythonPackage rec {
  pname = "twitterapi";
  version = "2.8.1";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "geduldig";
    repo = "TwitterAPI";
    rev = "v${version}";
    hash = "sha256-aBL7k10kZNQG/wNIxO37TbDSlbhrVjTfv2aXcrS2Ibo=";
  };

  propagatedBuildInputs = [
    requests
    requests-oauthlib
  ];

  # Tests are interacting with the Twitter API
  doCheck = false;

  pythonImportsCheck = [
    "TwitterAPI"
  ];

  meta = with lib; {
    description = "Python wrapper for Twitter's REST and Streaming APIs";
    homepage = "https://github.com/geduldig/TwitterAPI";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
