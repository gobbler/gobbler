module Gobbler
  class ClientVersion < Base
    def self.latest
      ::Gobbler.request("client_user/get_version_info")["data"]
    end
  end
end
