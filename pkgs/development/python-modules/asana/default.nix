{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
, pythonOlder
, requests
, requests-oauthlib
, responses
, six
}:

buildPythonPackage rec {
  pname = "asana";
  version = "2.0.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "asana";
    repo = "python-asana";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-sY7M446krFIcyWkN2pk9FTa+VTXEOZ6xnHePx35e8IY=";
  };

  propagatedBuildInputs = [
    requests
    requests-oauthlib
    six
  ];

  checkInputs = [
    pytestCheckHook
    responses
  ];

  pythonImportsCheck = [
    "asana"
  ];

  meta = with lib; {
    description = "Python client library for Asana";
    homepage = "https://github.com/asana/python-asana";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
