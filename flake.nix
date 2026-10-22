{
  description = "LaMa development shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
    in
    {
      devShells = nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              git
              gnumake
              m4
              (writeShellScriptBin "gm4" ''exec ${m4}/bin/m4 "$@"'')
              ocaml
              ocamlPackages.dune_3
              opam
              pcre2
              pkg-config
            ];

            shellHook = ''
              if [ ! -f "''${OPAMROOT:-$HOME/.opam}/config" ]; then
                opam init --bare --no-setup --yes
              fi
              if ! opam switch list --short | grep -qx lama-dev; then
                opam switch create lama-dev ocaml-system --yes
              fi
              eval "$(opam env --switch=lama-dev --set-switch)"
              export CAML_LD_LIBRARY_PATH="$(opam var lib)/stublibs''${CAML_LD_LIBRARY_PATH:+:$CAML_LD_LIBRARY_PATH}"
              opam install . --deps-only --yes
            '';
          };
        });
    };
}
