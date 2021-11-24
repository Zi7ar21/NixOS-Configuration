{ config, pkgs, ... }:

{
  networking.hostName = "Serverinet";
  networking.firewall.allowedTCPPorts = [ 22 8000 ];

  networking.interfaces.enp34s0.ipv4.addresses = [{
    address = "46.4.116.178";
    prefixLength = 27;
    gateway = "46.4.116.161";
  }];
}
