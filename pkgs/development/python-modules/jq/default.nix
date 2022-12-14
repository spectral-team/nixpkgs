{ buildPythonPackage, fetchPypi, lib, jq }:

buildPythonPackage rec {
  pname = "jq";
  version = "1.2.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-15bXqaa6c6RMoHKqUAcOhPrhMBbqYHrDdnZAaFaHElc=";
  };

  patches = [
    # Removes vendoring
    ./jq-py-setup.patch
  ];

  buildInputs = [ jq ];

  # no tests executed
  doCheck = false;
  pythonImportsCheck = [ "jq" ];

  meta = {
    description = "Python bindings for jq, the flexible JSON processor";
    homepage = "https://github.com/mwilliamson/jq.py";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ benley ];
  };
}
