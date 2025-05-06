{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      inter
      noto-fonts-emoji
      noto-fonts-cjk-sans
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      # kawkab-mono-font
      # (pkgs.stdenv.mkDerivation {
      #   name = "iran-yekan-fonts";
      #   src = "path:../../../fonts";
      #   dontUnpack = true;
      #   installPhase = ''
      #     mkdir -p $out/share/fonts/truetype
      #     cp $src/*.ttf $out/share/fonts/truetype
      #   '';
      # })
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Inter" "IRANYekanX" ];
        sansSerif = [ "Inter" "IRANYekanX" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };
}
