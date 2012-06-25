class UiController < ApplicationController
  layout "/ui/layouts/application"

  def login
    render :layout => "/ui/layouts/login"
  end

end
