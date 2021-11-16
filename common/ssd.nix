{ config, ... }:
{
    fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
}
