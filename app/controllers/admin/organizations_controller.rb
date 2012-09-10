class Admin::OrganizationsController < Admin::AdminController
  responders :flash
  
  def index
    @organizations = Organization.all
    respond_with(@organizations)
  end

  def new
    @organization = Organization.new
    respond_with(@organization)
  end
  
  def create
    @organization = Organization.create(params[:organization])
    respond_with(@organization, :location => admin_organizations_path)
  end
  
  def edit
    @organization = Organization.find(params[:id])
  end
  
  def update
    @organization = Organization.find(params[:id])
    @organization.update_attributes(params[:organization])
    respond_with(@organization, :location => admin_organizations_path)
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    respond_with(@organization, :location => admin_organizations_path)
  end

  
end
