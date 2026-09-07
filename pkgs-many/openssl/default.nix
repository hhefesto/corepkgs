{ mkManyVariants, callPackage }:

mkManyVariants {
  variants = ./variants.nix;
  aliases = { };
  name = "openssl";
  removed = {
    v1_1 = "2026-09-07";
  };
  defaultSelector = (p: p.v3_6);
  genericBuilder = ./generic.nix;
  inherit callPackage;
}
