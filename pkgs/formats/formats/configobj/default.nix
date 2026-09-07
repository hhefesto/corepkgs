{
  lib,
  pkgs,
}:
let
  inherit (lib.types)
    serializableValueWith
    ;
in
{
  format =
    { }:
    {
      type = serializableValueWith { typeName = "ConfigObj mapping"; };

      generate =
        name: value:
        pkgs.runCommandLocal name
          {
            nativeBuildInputs = [
              (pkgs.python3.withPackages (ps: [ ps.configobj ]))
            ];

            inherit value;
          }
          ''
            python3 ${./generate.py} > "$out"
          '';
    };
}
