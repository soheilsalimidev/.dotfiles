{ nixpkgs-lib }: rec {
  pow = base: exponent:
    let inherit (nixpkgs-lib) mod;
    in if exponent > 1 then
      let
        x = pow base (exponent / 2);
        odd_exp = mod exponent 2 == 1;
      in
      x * x * (if odd_exp then base else 1)
    else if exponent == 1 then
      base
    else if exponent == 0 && base == 0 then
      throw "undefined"
    else if exponent == 0 then
      1
    else
      throw "undefined";
}