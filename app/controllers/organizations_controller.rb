class OrganizationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.alphabetical
  end

  def show
    @organizatoin = Organization.find(params[:id])
    @affiliation = Affiliation.new
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
                # create an associated Org_user
                @org_user = OrgUser.new
                @org_user.organization_id = @organization.id
                @org_user.user_id = current_user.id
                @org_user.save

                # On default create a membership to the OrgUser/Admin/person_that_created_the_org
                @membership = Membership.new
                @membership.individual_id = current_user.individual.id
                @membership.organization_id = @organization.id
                @membership.save

        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  def send_sign_up_notice
    @orgMailer = OrganizationMailer.new(params[:organization_mailer])

    # making the temporary membership when an Admin user enters in an email
    #---------------------------------------------------------------------
        org_id = params[:organization_id]
        @membership = Membership.new
        @membership.organization_id = org_id
            # making the indiv for the temp membership
            @indiv = Individual.new
            @indiv.f_name = @orgMailer.email
            @indiv.l_name = " s" 
            @indiv.role = 0
            @indiv.save
        @membership.individual_id = @indiv.id
        @membership.save
    #---------------------------------------------------------------------

    if @orgMailer.deliver
      redirect_to organizations_path org_id, notice: 'Message sent'
    else
      redirect_to organizations_path org_id
      flash.now[:error] = 'Cannot send message.'
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :is_partner, :description, :activr, :department, :contact_id)
    end
end
