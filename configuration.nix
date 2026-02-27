{
  config,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./linode.nix
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;
  services.cloud-init.enable = true;

  nix.settings.trusted-users = ["root"];
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFMoK5tmhtGeKfTXfA51uIPV2kZGUXZYWAtEmDMNbdX7"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPiaayaWR+KgD/2gUke5ll5ZKHMLnTJx/3bfc2522qiQ"
    ];
  };

  system.stateVersion = "26.05";
}
