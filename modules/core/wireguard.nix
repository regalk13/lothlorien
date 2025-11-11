_: {
  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.8.71.3/32" ];
      dns = [ "1.1.1.1" ];
      listenPort = 51820;
      peers = [
        {
          publicKey = "0RKsm29oTNoiXqu6r6z1Crnx729jBtJSDNX1yya7aT0=";
          allowedIPs = [ "10.8.71.0/24" ];
          endpoint = "127.0.0.1:51821";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
