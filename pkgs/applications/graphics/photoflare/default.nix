{ mkDerivation, lib, graphicsmagick, fetchFromGitHub, qmake, qtbase, qttools
}:

mkDerivation rec {
  pname = "photoflare";
  version = "1.6.11";

  src = fetchFromGitHub {
    owner = "PhotoFlare";
    repo = "photoflare";
    rev = "v${version}";
    sha256 = "sha256-nXVTkkfRpbLZ+zUgnSzKNlVixI86eKoG5FO8GqgnrDY=";
  };

  nativeBuildInputs = [ qmake qttools ];
  buildInputs = [ qtbase graphicsmagick ];

  qmakeFlags = [ "PREFIX=${placeholder "out"}" ];

  NIX_CFLAGS_COMPILE = "-I${graphicsmagick}/include/GraphicsMagick";

  meta = with lib; {
    description = "A cross-platform image editor with a powerful features and a very friendly graphical user interface";
    homepage = "https://photoflare.io";
    maintainers = [ maintainers.omgbebebe ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
