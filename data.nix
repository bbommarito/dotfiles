{
  ageModules = {
    hashed-bbommarito-password.file = ./secrets/hashed-bbommarito-password-file.age;
  };

  pubkeys = let
    bbommarito = let
      nala = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAsQ3ycfZARDPcsTE6UkpMCdsAPwNBmCAYGpQfD6IeDt"
      ];
    in {
      inherit nala;

      computers = nala;
    };
  in {
    inherit bbommarito;
  };
}
