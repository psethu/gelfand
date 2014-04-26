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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    def membership_params
    	params.require(:membership).permit(:organization_id, :individual_id)
	end

end