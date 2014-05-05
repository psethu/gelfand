class OrgUsersController < ApplicationController

  def create
   @org_user = OrgUser.new(org_user_params)

    puts "\n \n"
    puts "Hello"
    puts "\n \n"
    # before saving the orgUser with new params, have to delete the one belonging to the org
        @current_orgUser_to_delete = OrgUser.find_by(organization_id: @org_user.organization_id)
        @current_orgUser_to_delete.delete

    if @org_user.save!
      # if saved to database
      indiv = User.find(@org_user.user_id).individual
      org = Organization.find(@org_user.organization_id)
    
      redirect_to organizations_path
      flash[:notice] = "Successfully made #{indiv.name} as admin for: #{org.name} ."
    end

  end

  # DELETE
  # DELETE
  def destroy

    @org_user = OrgUser.find(params[:id]) 

    @org_user.destroy
    respond_to do |format|
      format.html { redirect_to organizations_path }
      format.json { head :no_content }
    end
  end


  private
  def org_user_params
    params.require(:org_user).permit(:organization_id, :user_id)
  end

end