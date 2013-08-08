module Gobbler
 
  # Alias for {Folder.get}
  # @param guid [String] The guid of the folder
  # @return [Folder]
  def self.folder(guid); Folder.get(guid); end

  # Alias for {Folder.list}
  # @return [Array<Folder>] An array of Folders
  def self.folders(opts = {}); Folder.list(opts); end

  class Folder < Base

    # @return [Array<Folder>] An array of Folders
    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_catalog/sync_ask_folder", options: opts)["updates"].map {|folder| new(folder)}
    end

    # @return [String] The guid for the folder
    def guid
      user_data_guid
    end

    # @return [Volume] The volume that this folder is on
    def volume
      ::Gobbler::Volume.get(volume_guid)
    end

    # @return [Hash] The assets for this folder
    def assets
      ::Gobbler.unpack json["dir"]["assets_packed"]
    end
  end
end
