class OrgUsersController < ApplicationController



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