{ lib, fetchzip }:

let
  pname = "restinio";
  version = "0.6.17";
in
fetchzip {
  name = "${pname}-${version}";
  url = "https://github.com/Stiffstream/restinio/releases/download/v.${version}/${pname}-${version}.tar.bz2";
  hash = "sha256-8A13r3Qsn5S+kVWLPENoOjqz2tPMxSo6EWBvHG1cTAE=";

  stripRoot = false;
  postFetch = ''
    mkdir -p $out/include
    mv $out/restinio-*/dev/restinio $out/include
    rm -r $out/restinio-*
  '';

  meta = with lib; {
    description = "Cross-platform, efficient, customizable, and robust asynchronous HTTP/WebSocket server C++14 library";
    homepage = "https://github.com/Stiffstream/restinio";
    license = licenses.bsd3;
    platforms = platforms.all;
  };
}
