{ config, pkgs, ... }:

let
  tex =
    (pkgs.texliveMedium.withPackages (
      ps: with ps; [
        # List all packages you need – even those already in texliveMedium
        # (duplicates are ignored, so it's safe to be exhaustive).
        dvisvgm
        dvipng
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        titlesec
        tcolorbox
        xepersian
        eso-pic
        xetex
        bidi
        zref
        currfile
        vwcol
        natbib
        cfr-lm
        svn-prov
        nfssext-cfr
        inter
        enumitem
        xhfill
        fontawesome5
        totalcount
        fancyhdr
        amsfonts
        fontaxes
        multirow
        biblatex
        tabulary
        subfig
        caption
        adjustbox
        tocloft
        tocbibind
        framed
        setspace
        morewrites
        float
        booktabs
        lastpage
      ]
    )).overrideAttrs
      {
        # Enable documentation (optional)
        # withSources = true;   # uncomment to include source containers
      };

in
{
  environment.systemPackages = with pkgs; [
    tex
    zathura
    biber
  ];
}
