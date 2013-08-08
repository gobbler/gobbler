module Gobbler
  
  # Alias for {Gobbler::Project.get}
  # @param guid [String] The guid of the project
  # @return [Project]
  def self.project(guid); Project.get(guid); end

  # Alias for {Gobbler::Project.list}
  # @return [Array<Project>] An array of Backed up projects
  def self.projects(opts = {}); Project.list(opts); end

  # Projects that you have backed up with Gobbler
  class Project < Base

    # @return [Array<Project>] an array of Gobbler Projects
    def self.list(opts = {})
      opts[:offset] ||= 0
      ::Gobbler.request("client_project/sync_ask", options: opts)["updates"].map {|project| new(project)}
    end

    # Get the last checkpoint for a project
    # @return [Checkpoint]
    def last_checkpoint
      ::Gobbler::Checkpoint.get(project_id: guid, checkpoint: current_checkpoint["num"])
    end

    # @return [Array<Checkpoint>] an array of Checkpoints for this project
    def checkpoints
      (1..current_checkpoint["num"]).map do |checkpoint_num|
       ::Gobbler::Checkpoint.get(project_id: guid, checkpoint: checkpoint_num)
      end
    end

    # @return [Hash] The information about the email sent
    def email_to(recipients, opts = {})
      params = {guid: guid, recipients: recipients}
      params[:is_public] = opts[:public] if opts[:public] == true
      params[:checkpoint] = opts[:checkpoint] if opts[:checkpoint]
      ::Gobbler.request("client_mailbox/send_project", params)
    end
  end
end
