{ config, pkgs, ... }:

{
  networking.hostName = "Workstation";
  networking.networkmanager.enable = false;
  networking.firewall.allowedTCPPorts = [ 22 8000 ];

  networking.useDHCP = false;

  networking.vlans = {
    lan = { id=200; interface="enp9s0"; };
    genMGMT = { id=300; interface="enp9s0"; };
    bridgeMGMT = { id=1001; interface="enp9s0"; };
    apMGMT = { id=202; interface="enp9s0"; };
    #vpn = { id=500; interface="enp9s0"; };
  };

  networking.interfaces.enp9s0.useDHCP = false;
  networking.interfaces.lan.useDHCP = true;
  #networking.interfaces.vpn.useDHCP = true;
  networking.interfaces.bridgeMGMT.useDHCP = false;
  networking.interfaces.apMGMT.useDHCP = false;
  networking.interfaces.genMGMT.useDHCP = false;

  
  networking.interfaces.genMGMT.ipv4.addresses = [{
    address = "192.168.100.254";
    prefixLength = 24;
  }];

  networking.interfaces.bridgeMGMT.ipv4.addresses = [{
    address = "192.168.88.254";
    prefixLength = 24;
  }];
 
  networking.interfaces.apMGMT.ipv4.addresses = [{
    address = "10.20.2.254";
    prefixLength = 24;
  }];


  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.200.200.2/24" ];
      privateKeyFile = "/root/wireguard/private.key";
      peers = [
        {
          publicKey = "K7HNf1Wjw/4vZLZYvbwiDhE3QIYghJNurZIHkMEwj0A=";
          allowedIPs = [ "10.200.200.0/24" ];
          endpoint = "abbasg.com:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  networking.extraHosts =
  ''
    127.0.0.1 greg.192.168.1.126.nip.io
    127.0.0.1 api.greg.192.168.1.126.nip.io
    127.0.0.1 assets.greg.192.168.1.126.nip.io
    127.0.0.1 stel.greg.192.168.1.126.nip.io
  '';
}
