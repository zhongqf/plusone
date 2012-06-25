class TlController < ApplicationController
  layout "/tl/layouts/application"

  def login
    render :layout => "/tl/layouts/login"
  end

end
