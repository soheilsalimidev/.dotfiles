{ config, pkgs, ... }:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-medium
        dvisvgm
        dvipng # for preview and export as html
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
        # Add these to your inherit list in pkgs.texlive.combine:
        tabulary # For tabular with adjustable columns
        subfig # For subfigures/subcaptions
        caption # For customizing captions
        adjustbox # For figure adjustments (needed with [export] option)
        tocloft # For customizing table of contents
        tocbibind # For including bibliography in TOC
        framed # You already have this - but verify it's available
        setspace # For line spacing
        morewrites # For handling write streams
        float # For H placement option
        booktabs # You already have this - but verify
      lastpage
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  # home-manager
  environment.systemPackages = with pkgs; [
    tex
    zathura
    biber
  ];
}
