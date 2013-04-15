
class Manager::NodesController < Manager::ManagerController

  before_filter :setup_defaults

  def push_commit
    # @result = `cd ~/projects/microsites && be rake test && be rspec spec && git add . && git commit -am "automatic" && git push origin master`
  end
  
  def run_client
    node = @nodes.select { |n| n[:node_name] == params[:node_name] }[0]
    Net::SSH.start( @host, @user, :port => node[:port], :keys => @keys ) do|ssh|
      @result = ''
      @result = @result + ssh.exec!('sudo chef-client')
    end    
  end

  def restart_service
    ;
  end

  def run_tests
    # @result_1 = ''
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && be rspec spec`
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && be rake test`
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && be rake assets:precompile && git add . && git commit -am "automated commit" && git push origin master`
    # @result_1 = @result_1 + `cd ~/projects/microsites2 && rm -rf public/assets`
  end

  private

  def setup_defaults
    @host = 'infiniteshelter.com'
    @user = 'ubuntu'
    @chef_workdir = "/home/piousbox/projects/rails-quick-start"
    @keys = [ "/home/piousbox/projects/rails-quick-start/rails-quick-start.pem" ]

  end
  
end
