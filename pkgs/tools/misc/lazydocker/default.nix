{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "lazydocker";
  version = "0.20.0";

  src = fetchFromGitHub {
    owner = "jesseduffield";
    repo = "lazydocker";
    rev = "v${version}";
    sha256 = "sha256-P03L3UbXAlNUUwAwDqsIIs/ECB6s3GqCESbPK4AgnYg=";
  };

  vendorSha256 = null;

  postPatch = ''
    rm -f pkg/config/app_config_test.go
  '';

  excludedPackages = [ "scripts" "test/printrandom" ];

  ldflags = [ "-s" "-w" "-X main.version=${version}" ];

  meta = with lib; {
    description = "A simple terminal UI for both docker and docker-compose";
    homepage = "https://github.com/jesseduffield/lazydocker";
    license = licenses.mit;
    maintainers = with maintainers; [ das-g Br1ght0ne ];
  };
}
