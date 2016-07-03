{ stdenv, go16Packages, runc }:

go16Packages.buildFromGitHub {
   rev = "1.7";
   owner = "tianon";
   repo = "gosu";
   sha256 = "02vln88yyhj8k8cyzac0sgw84626vshmzdrrc1jpl4k4sc27vcbp";
   propagatedBuildInputs = [ runc ];
}
