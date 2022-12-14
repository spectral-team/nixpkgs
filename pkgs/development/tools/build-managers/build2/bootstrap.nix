{ lib, stdenv
, fetchurl
, pkgs
, fixDarwinDylibNames
}:
stdenv.mkDerivation rec {
  pname = "build2-bootstrap";
  version = "0.15.0";
  src = fetchurl {
    url = "https://download.build2.org/${version}/build2-toolchain-${version}.tar.xz";
    sha256 = "1i1p52fr5sjs5yz6hqhljwhc148mvs4fyq0cf7wjg5pbv9wzclji";
  };
  patches = [
    # Pick up sysdirs from NIX_LDFLAGS
    ./nix-ldflags-sysdirs.patch
  ];

  sourceRoot = "build2-toolchain-${version}/build2";
  makefile = "bootstrap.gmake";
  enableParallelBuilding = true;

  setupHook = ./setup-hook.sh;

  strictDeps = true;

  propagatedBuildInputs = lib.optionals stdenv.targetPlatform.isDarwin [
    fixDarwinDylibNames
  ];

  doCheck = true;
  checkPhase = ''
    runHook preCheck
    build2/b-boot --version
    runHook postCheck
  '';

  installPhase = ''
    runHook preInstall
    install -D build2/b-boot $out/bin/b
    runHook postInstall
  '';

  inherit (pkgs.build2) passthru;
}
