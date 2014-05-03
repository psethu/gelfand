class ParticipantsController < ApplicationController

  def index
  	@participants = Participant.all
  end

  def create
    @participant = Participant.new(participant_params)
    if @participant.save!
      # if saved to database
      program_name = Program.find(@participant.program_id).name
      redirect_to organizations_path

      flash[:notice] = "Successfully created participant with #{program_name}."
    else
      redirect_to organizations_path
    end
  end


  private
  def participant_params
    params.require(:participant).permit(:program_id, :individual_id)
  end

end