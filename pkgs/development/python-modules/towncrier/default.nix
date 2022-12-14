{ lib, buildPythonPackage, fetchPypi, isPy27
, click
, click-default-group
, incremental
, jinja2
, mock
, pytestCheckHook
, toml
, twisted
, setuptools
, git # shells out to git
}:

buildPythonPackage rec {
  pname = "towncrier";
  version = "22.8.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-fTg5sDOFm0X7Vd+Ct0z9cCQxkzwMyfKHpafqPgXQQss=";
  };

  propagatedBuildInputs = [
    click
    click-default-group
    incremental
    jinja2
    toml
    setuptools
  ];

  # zope.interface collision
  doCheck = !isPy27;

  preCheck = ''
    export PATH=$out/bin:$PATH
  '';

  checkInputs = [
    git
    mock
    twisted
    pytestCheckHook
  ];

  pythonImportsCheck = [ "towncrier" ];

  meta = with lib; {
    description = "Utility to produce useful, summarised news files";
    homepage = "https://github.com/twisted/towncrier/";
    license = licenses.mit;
    maintainers = with maintainers; [  ];
  };
}
