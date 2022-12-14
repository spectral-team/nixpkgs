{ lib, stdenv, fetchFromGitHub, pkg-config, openssl, autoreconfHook }:

stdenv.mkDerivation rec {
  pname = "pkcs11-helper";
  version = "1.29.0";

  src = fetchFromGitHub {
    owner = "OpenSC";
    repo = "pkcs11-helper";
    rev = "${pname}-${version}";
    sha256 = "sha256-HPaPmsCJ81NaS7mgRGbR7KFG6AM3s6HXdWKdfREhcLc=";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];
  buildInputs = [ openssl ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://github.com/OpenSC/pkcs11-helper";
    license = with licenses; [ bsd3 gpl2Only ];
    description = "Library that simplifies the interaction with PKCS#11 providers";
    platforms = platforms.unix;
  };
}
