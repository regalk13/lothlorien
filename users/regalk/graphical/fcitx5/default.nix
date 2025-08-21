{ config, ... }:

{
  # freeze profile so Rime is default, no configtool needed
  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=rime

    [Groups/0/Items/0]
    Name=keyboard-us
    Layout=

    [Groups/0/Items/1]
    Name=rime
    Layout=

    [GroupOrder]
    0=Default
  '';

  # optional: a backup that your Hypr exec-once can restore from
  xdg.configFile."fcitx5/profile-bak".text = config.xdg.configFile."fcitx5/profile".text;
}
