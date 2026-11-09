{ host, pkgs, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) thunarEnable;
in
{
  environment.systemPackages = with pkgs; [
    evince
    gdk-pixbuf
     # For general HEIF container support (this includes the AVIF file format) 
    libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)

    # For more newer AVIF specific support usually not needed if libheif is installed
    libavif
    
    # For JXL(JPEG XL) support
    libjxl
    
    # For WebP support
    webp-pixbuf-loader
  ];

}
