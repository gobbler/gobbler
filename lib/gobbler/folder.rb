module Gobbler
  
  def self.folder(guid); Folder.get(guid); end
  def self.folders(opts = {}); Folder.list(opts); end

  class Folder < Base
    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_catalog/sync_ask_folder", options: opts)["updates"].map {|folder| new(folder)}
    end

    def guid
      user_data_guid
    end

    def volume
      ::Gobbler::Volume.get(volume_guid)
    end

    def assets
      ::Gobbler.unpack json["dir"]["assets_packed"]
    end
  end
end
