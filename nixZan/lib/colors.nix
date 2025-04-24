{ nixpkgs-lib, math ? import ./math.nix { inherit nixpkgs-lib; }, }:
let
  hexToDecMap = {
    "0" = 0; "1" = 1; "2" = 2; "3" = 3; "4" = 4;
    "5" = 5; "6" = 6; "7" = 7; "8" = 8; "9" = 9;
    "a" = 10; "b" = 11; "c" = 12; "d" = 13; "e" = 14; "f" = 15;
  };

  base16To10 = exponent: scalar: scalar * math.pow 16 exponent;

  hexCharToDec = hex:
    let
      inherit (nixpkgs-lib) toLower;
      lowerHex = toLower hex;
    in
    if builtins.stringLength hex != 1 then
      throw "Function only accepts a single character."
    else if hexToDecMap ? ${lowerHex} then
      hexToDecMap."${lowerHex}"
    else
      throw "Character ${hex} is not a hexadecimal value.";
in
rec {
  hexToDec = hex:
    let
      inherit (nixpkgs-lib) stringToCharacters reverseList imap0 foldl;
      decimals = builtins.map hexCharToDec (stringToCharacters hex);
      decimalsAscending = reverseList decimals;
      decimalsPowered = imap0 base16To10 decimalsAscending;
    in
    foldl builtins.add 0 decimalsPowered;

  hexToRGB = hex:
    let
      rgbStartIndex = [ 0 2 4 ];
      hexList = builtins.map (x: builtins.substring x 2 hex) rgbStartIndex;
      hexLength = builtins.stringLength hex;
    in
    if hexLength != 6 then
      throw "Hex string length must be exactly 6."
    else
      builtins.map hexToDec hexList;

  hexToRGBString = sep: hex:
    let
      inherit (builtins) map toString;
      inherit (nixpkgs-lib) concatStringsSep;
      hexInRGB = hexToRGB hex;
      hexInRGBString = map toString hexInRGB;
    in
    concatStringsSep sep hexInRGBString;
}
