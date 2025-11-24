{ username, pkgs, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
  };
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  nix.settings.trusted-users = [ username ];
  users.defaultUserShell = pkgs.nushell;
}
