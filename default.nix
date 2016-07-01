with import <nixpkgs> {};
let
  gb = (callPackage ./src/nix/gb {}).bin // { outputs = [ "bin" ]; };
  riot = (callPackage ./src/nix/riot {});
in
{
  myEnv = stdenv.mkDerivation {
    name = "go-gb-env";
    buildInputs = [ go_1_6 gb riot ];
    shellHook = ''
        export GOROOT="${go_1_6}/share/go"
        export GOPATH="$PWD/.go:$PWD/vendor:$PWD"
        export GOBIN="$PWD/.go/bin"
        export PATH="$PATH:$GOBIN"
    '';
  };
}
