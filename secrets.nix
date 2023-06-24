let
  keys = (import ./data.nix).pubkeys;

  bbommarito = keys.bbommarito.nala ++ keys.bbommarito.personal;
in {
  "secrets/hashed-bbommarito-password-file.age".publicKeys = bbommarito;
}
