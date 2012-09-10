module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /the login page/
      new_user_session_path
    when /the home\s?page/
      root_path
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        path_name = path_components.push('path').join('_')
        self.send(path_name.to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" [#{path_name}] to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)