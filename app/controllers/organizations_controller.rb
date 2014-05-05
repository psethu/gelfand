class OrganizationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all.alphabetical
    @participant = Participant.new
    @users = User.all.map{|user| user} #Individual.all.map{|indiv| indiv.user.id}
    @names_from_users = []
    @users.each do |user|
        # if user does not have an individual, then just use email
        if user.individual.nil?
          @names_from_users << [user.email, user.id]
        else
          @names_from_users << [user.individual.name, user.id]
        end
    end
    @names_from_users.sort!
  end

  def show
    @organizatoin = Organization.find(params[:id])
    @affiliation = Affiliation.new
  end

  def org_overview
    @organizations = Organization.all
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

  def send_sign_up_notice_if_no_indiv_exists
      # doing stuff here so take care of redundant code
      @orgMailer = OrganizationMailer.new(params[:organization_mailer])
      @membership = Membership.new
      # this is so dont have to add org_id to @mem in the if AND else clauses
      org_id = params[:organization_id]
      @membership.organization_id = org_id
      # this is so can get the User from the passed in email from params hash
      @user = User.find_by email: @orgMailer.currently_registered_email      

      # send notice if no User exists, 
      # if User exists make the Membership with existing Individual since if User exists, the
          # connected Individual must also exist because this happens when signing up
      if (!@user.nil?)
          @indiv = Individual.find_by user_id: @user.id
           @membership.individual_id = @indiv.id
           if @membership.save
              redirect_to organization_path(org_id), notice: "Added member: #{@indiv.f_name}"
           else
              redirect_to organization_path(org_id),  notice: "Cannot send notice."
            end
     
      else
            # making the temporary membership when an Admin user enters in an email
            #---------------------------------------------------------------------
                    # making the indiv for the temp membership
                    @indiv = Individual.new
                    @indiv.f_name = @orgMailer.currently_registered_email
                    @indiv.l_name = "Temp: " 
                    @indiv.role = 0
                    @indiv.save
                @membership.individual_id = @indiv.id
                @membership.save
            #---------------------------------------------------------------------

            if @orgMailer.deliver
              redirect_to organization_path(org_id), notice: "Notice sent to \"#{@orgMailer.currently_registered_email}\""
            else
              redirect_to organization_path(org_id)
              flash.now[:error] = 'Cannot send notice.'
            end
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
