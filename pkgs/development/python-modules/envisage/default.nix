{ lib
, apptools
, buildPythonPackage
, fetchPypi
, ipython
, pytestCheckHook
, pythonAtLeast
, pythonOlder
, setuptools
, traits
}:

buildPythonPackage rec {
  pname = "envisage";
  version = "6.1.0";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-AATsUNcYLB4vtyvuooAMDZx8p5fayijb6yJoUKTCW40=";
  };

  # for the optional dependency ipykernel, only versions < 6 are
  # supported, so it's not included in the tests, and not propagated
  propagatedBuildInputs = [
    traits
    apptools
    setuptools
  ];

  preCheck = ''
    export HOME=$PWD/HOME
  '';

  checkInputs = [
    ipython
    pytestCheckHook
  ];

  disabledTestPaths = lib.optionals (pythonAtLeast "3.10") [
    # https://github.com/enthought/envisage/issues/455
    "envisage/tests/test_egg_basket_plugin_manager.py"
    "envisage/tests/test_egg_plugin_manager.py"
  ];

  pythonImportsCheck = [
    "envisage"
  ];

  meta = with lib; {
    description = "Framework for building applications whose functionalities can be extended by adding plug-ins";
    homepage = "https://github.com/enthought/envisage";
    license = licenses.bsdOriginal;
    maintainers = with lib.maintainers; [ knedlsepp ];
  };
}
