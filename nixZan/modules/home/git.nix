{ host, ... }:
let inherit (import ../../hosts/${host}/variables.nix) gitUsername gitEmail;
in {
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    extraConfig = {
      commit.gpgsign = true;
      tag.gpgSign = true;
      gpg.format = "openpgp";
      user.signingkey = "154B407A046883ED";
    };
  };
}
