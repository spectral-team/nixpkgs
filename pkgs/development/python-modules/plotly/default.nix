{ lib
, buildPythonPackage
, fetchPypi
, pytz
, requests
, six
, tenacity
}:

buildPythonPackage rec {
  pname = "plotly";
  version = "5.10.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-TTbZhZt6FTsnNWLe7tjCklh6Ry6x/VfNQVjsidne+ts=";
  };

  propagatedBuildInputs = [
    pytz
    requests
    six
    tenacity
  ];

  # No tests in archive
  doCheck = false;

  meta = with lib; {
    description = "Python plotting library for collaborative, interactive, publication-quality graphs";
    homepage = "https://plot.ly/python/";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ ];
  };
}
