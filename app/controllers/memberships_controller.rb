class MembershipsController < ApplicationController
	before_action :set_membership, only: [:destroy]

  def create
    @membership = Membership.new(membership_params)
    if @membership.save!
      # if saved to database
      org = Organization.find(@membership.organization_id)
      flash[:notice] = "Successfully created membership with #{org.name}."
      redirect_to organization_path(org.id) # go to show org page
    else
      # if could not save new membership
      flash[:notice] = "Could not add member to #{org.name}."
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to organization_path(Organization.find(@membership.organization_id)) }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    if @memberships.nil?
        redirect_to organizations_path
        flash[:notice] = "\n \n No members were checked!"
    else
          @memberships = Membership.find(params[:membership_ids])
          # Below used 'first' but can get any of the memObjects. Just need 1 org_Id since all these 
            # memberships belong to the same org
          org_id = @memberships.first.organization_id
          @memberships.each do |mem| 
              mem.delete
          end
          # gets the rest of the memberships of the Org that were not checked to be deleted
          @memberships = Membership.for_organization(org_id)
          respond_to do |format|
            format.html { redirect_to organization_path(Organization.find(org_id)) }
            format.json { head :no_content }
          end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def membership_params
    	params.require(:membership).permit(:organization_id, :individual_id)
	end

end