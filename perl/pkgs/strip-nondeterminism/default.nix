{
  ArchiveZip,
  fetchFromGitLab,
  lib,
  buildPerlPackage,
}:

buildPerlPackage {
  pname = "strip-nondeterminism";
  version = "1.14.0";

  src = fetchFromGitLab {
    domain = "salsa.debian.org";
    owner = "reproducible-builds";
    repo = "strip-nondeterminism";
    tag = "1.14.0";
    hash = "sha256-+C+gVvBe6vkpJRM0AJ/Am3dYDP019Ckx5GTFU5CooHI=";
  };

  propagatedBuildInputs = [
    ArchiveZip
  ];

  installTargets = [ "install" ];

  meta = {
    description = "Tool for stripping bits of non-deterministic information from files";
    homepage = "https://reproducible-builds.org/";
    license = lib.licenses.gpl3Plus;
    mainProgram = "strip-nondeterminism";
  };
}
