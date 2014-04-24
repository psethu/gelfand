class AffiliationsController < ApplicationController

  def index
  	@affiliations = Affiliation.all
  end

  def create
    @affiliation = Affiliation.new(affiliation_params)
    if @affiliation.save!
      # if saved to database
      org_name = Organization.find(@affiliation.organization_id).name
      flash[:notice] = "Successfully created affiliation with #{org_name}."
      redirect_to program_path(@affiliation.program_id) # go to show program page
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end


  private
  def affiliation_params
    params.require(:affiliation).permit(:organization_id, :program_id, :description, :followed_process)
  end

end