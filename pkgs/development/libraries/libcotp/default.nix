{ stdenv, lib, fetchFromGitHub, cmake, pkg-config, libgcrypt }:

stdenv.mkDerivation rec {
  pname = "libcotp";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "paolostivanin";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-QvDYdplPhivG4a2otT4MuSY546a2Dw/amWly5aheabQ=";
  };

  postPatch = lib.optionalString stdenv.cc.isClang ''
    substituteInPlace CMakeLists.txt \
      --replace "add_link_options(-Wl," "# add_link_options(-Wl,"
  '';

  buildInputs = [ libgcrypt ];
  nativeBuildInputs = [ cmake pkg-config ];

  meta = with lib; {
    description = "C library that generates TOTP and HOTP";
    homepage = "https://github.com/paolostivanin/libcotp";
    license = licenses.asl20;
    maintainers = with maintainers; [ alexbakker ];
    platforms = platforms.all;
  };
}
