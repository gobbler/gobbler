module Gobbler
  
  def self.project(guid); Project.get(guid); end
  def self.projects(opts = {}); Project.list(opts); end

  class Project < Base
    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_project/sync_ask", options: opts)["updates"].map {|project| new(project)}
    end

    def last_checkpoint
      ::Gobbler::Checkpoint.get(project_id: guid, checkpoint: current_checkpoint["num"])
    end

    def checkpoints
      (1..current_checkpoint["num"]).map do |checkpoint_num|
       ::Gobbler::Checkpoint.get(project_id: guid, checkpoint: checkpoint_num)
      end
    end

    def email_to(recipients, opts = {})
      params = {guid: guid, recipients: recipients}
      params[:is_public] = opts[:public] if opts[:public] == true
      params[:checkpoint] = opts[:checkpoint] if opts[:checkpoint]
      ::Gobbler.request("client_mailbox/send_project", params)
    end
  end
end
