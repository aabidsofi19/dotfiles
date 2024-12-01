# devshells/default.nix
{ pkgs, lib, inputs }:
{
  postgres = import ./postgres.nix { inherit pkgs lib; };
}
