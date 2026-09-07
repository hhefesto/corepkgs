{
  lib,
  stdenv,
  fetchurl,
  removeReferencesTo,
  testers,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pkgconf";
  version = "2.4.3";

  src = fetchurl {
    url = "https://distfiles.ariadne.space/pkgconf/pkgconf-${finalAttrs.version}.tar.xz";
    hash = "sha256-USA9me1XP6c0S/B8pibxDHzAlOCEasSqACO9DIPCWkE=";
  };

  outputs = [
    "out"
    "lib"
    "dev"
    "man"
    "doc"
  ];

  nativeBuildInputs = [ removeReferencesTo ];

  # pkgconf ships its own pkg-config compatibility, install it
  postInstall = ''
    ln -s pkgconf "$out/bin/pkg-config"
  '';

  # Debian has outputs like these too
  # (https://packages.debian.org/source/bullseye/pkgconf), so it is safe to
  # remove those references
  postFixup = ''
    remove-references-to \
      -t "${placeholder "out"}" \
      "${placeholder "lib"}"/lib/*
    remove-references-to \
      -t "${placeholder "dev"}" \
      "${placeholder "lib"}"/lib/* \
      "${placeholder "out"}"/bin/*
  ''
  # Move back share/aclocal. Yes, this normally goes in the dev output for good
  # reason, but in this case the dev output is for the `libpkgconf` library,
  # while the aclocal stuff is for the tool. The tool is already for use during
  # development, so there is no reason to have separate "dev-bin" and "dev-lib"
  # outputs or something.
  + ''
    mv ${placeholder "dev"}/share ${placeholder "out"}
  '';

  passthru.tests.version = testers.testVersion {
    package = finalAttrs.finalPackage;
  };

  meta = {
    description = "Package compiler and linker metadata toolkit";
    homepage = "https://gitea.treesitter.net/ariadne/pkgconf";
    license = lib.licenses.isc;
    platforms = lib.platforms.all;
    mainProgram = "pkgconf";
  };
})
