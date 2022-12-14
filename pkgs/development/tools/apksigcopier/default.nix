{ lib
, apksigner
, bash
, fetchFromGitHub
, installShellFiles
, pandoc
, python3
}:

python3.pkgs.buildPythonApplication rec {
  pname = "apksigcopier";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "obfusk";
    repo = "apksigcopier";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-58NoYe26GsNE0jpSRt4sIkTJ2iR4VVnvthOfi7QFfN0=";
  };

  nativeBuildInputs = [
    installShellFiles
    pandoc
  ];

  propagatedBuildInputs = with python3.pkgs; [
    click
  ];

  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    "${lib.makeBinPath [ apksigner ]}"
  ];

  postPatch = ''
    substituteInPlace Makefile \
      --replace /bin/bash ${bash}/bin/bash
  '';

  postBuild = ''
    make ${pname}.1
  '';

  postInstall = ''
    installManPage ${pname}.1
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/apksigcopier --version | grep "${version}"
    runHook postInstallCheck
  '';

  meta = with lib; {
    description = "Copy/extract/patch android apk signatures & compare APKs";
    longDescription = ''
      apksigcopier is a tool for copying android APK signatures from a signed
      APK to an unsigned one (in order to verify reproducible builds).
      It can also be used to compare two APKs with different signatures.
      Its command-line tool offers four operations:

      * copy signatures directly from a signed to an unsigned APK
      * extract signatures from a signed APK to a directory
      * patch previously extracted signatures onto an unsigned APK
      * compare two APKs with different signatures (requires apksigner)
    '';
    homepage = "https://github.com/obfusk/apksigcopier";
    license = with licenses; [ gpl3Plus ];
    maintainers = with maintainers; [ obfusk ];
  };
}
