{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of titlesec tcolorbox xepersian eso-pic
      xetex bidi zref currfile vwcol natbib cfr-lm svn-prov nfssext-cfr inter
      enumitem xhfill fontawesome5 totalcount fancyhdr amsfonts fontaxes biblatex;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });
in { # home-manager
  environment.systemPackages = with pkgs; [ tex zathura biber ];
}
