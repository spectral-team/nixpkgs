{ lib
, aiohttp
, buildPythonPackage
, fetchFromGitHub
, pycryptodome
, pythonOlder
}:

buildPythonPackage rec {
  pname = "aioairq";
  version = "0.3.1";
  format = "setuptools";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "CorantGmbH";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-SRsDSHTZkkygaQZjHENKNLx3ZWMi/PubS1m/MonEKNk=";
  };

  propagatedBuildInputs = [
    aiohttp
    pycryptodome
  ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [
    "aioairq"
  ];

  meta = with lib; {
    description = "Library to retrieve data from air-Q devices";
    homepage = "https://github.com/CorantGmbH/aioairq";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
