{ lib, buildDunePackage, fetchurl
, fmt, mirage-flow, cstruct, logs, ke, lwt
, alcotest, alcotest-lwt, bigstringaf
}:

buildDunePackage rec {
  pname = "mimic";
  version = "0.0.5";

  minimalOCamlVersion = "4.08";

  src = fetchurl {
    url = "https://github.com/dinosaure/mimic/releases/download/${version}/mimic-${version}.tbz";
    sha256 = "sha256-3qFjttVLgXKHOsr71550z7aVBcHPYzwdFeMpwHgWPa0=";
  };

  propagatedBuildInputs = [
    fmt
    lwt
    mirage-flow
    logs
  ];

  doCheck = true;
  checkInputs = [
    alcotest
    alcotest-lwt
    bigstringaf
    cstruct
    ke
  ];

  meta = with lib; {
    description = "A simple protocol dispatcher";
    license = licenses.isc;
    homepage = "https://github.com/mirage/ocaml-git";
    maintainers = [ maintainers.sternenseemann ];
  };
}
