{
  config,
  pkgs,
  ...
}: {
  system.autoUpgrade = {
    enable = true;
    flake = "github:push-and-pray/friendly-octo-broccoli";
  };
  nix.settings = {
    substituters = [ "https://harmonia.altanen.casa" ];
    trusted-public-keys = [ "altanen-cache:FyBhI6Zc9cYE/+Xn7KkrY+az5VzmH1BDQ/o9CmbzoNM=" ]; 
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "nixos";
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
