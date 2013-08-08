module Gobbler
  class ClientVersion < Base

    # @return [ClientVersion] The information about the latest client
    def self.latest
      ::Gobbler.request("client_user/get_version_info")["data"]
    end
  end
end
