{ lib, stdenv, fetchurl, pkg-config
, alsa-lib, fftw, gsl, motif, xorg
, CoreServices, CoreMIDI
}:

stdenv.mkDerivation rec {
  pname = "snd";
  version = "23.8";

  src = fetchurl {
    url = "mirror://sourceforge/snd/snd-${version}.tar.gz";
    sha256 = "sha256-g2+7i1+TgX17TpW1mHSdAzHKC/Gtm4NYZCmuVoPo2rg=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ fftw gsl motif ]
    ++ lib.optionals stdenv.isLinux [ alsa-lib ]
    ++ lib.optionals stdenv.isDarwin [ CoreServices CoreMIDI ]
    ++ (with xorg; [ libXext libXft libXpm libXt ]);

  configureFlags = [ "--with-motif" ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Sound editor";
    homepage = "https://ccrma.stanford.edu/software/snd/";
    platforms = platforms.unix;
    license = licenses.free;
    maintainers = with maintainers; [ ];
  };
}
