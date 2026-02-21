{
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "my-new-machine";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "nixos";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFMoK5tmhtGeKfTXfA51uIPV2kZGUXZYWAtEmDMNbdX7"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "26.05";
}
