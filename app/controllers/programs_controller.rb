class ProgramsController < ApplicationController
  load_and_authorize_resource
  before_action :set_program, only: [:edit, :update, :destroy]

def new
  @program = Program.new
  @contact = Contact.new
end

def individuals_list
  @program = Program.find(params[:id])
  @cleared = @program.cleared_participants
  @not_cleared = @program.uncleared_participants
end

def ongoing
  @ongoing = Program.current
end

def completed
  @completed = Program.completed
end

def upcoming
  @upcoming = Program.upcoming
end

  # GET /programs
  # GET /programs.json
  def index
    @programs = Program.all
    @upcoming_progs = Program.upcoming
    @in_progress = Program.current
  end

  def show
    @program = Program.find(params[:id])
    @affiliation = Affiliation.new
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = Program.new(program_params)
    @contact = Contact.new(contact_params)
    @contact.save!
    @program.contact_id = @contact.id
    respond_to do |format|
      if @program.save        
        format.html { redirect_to @program, notice: 'Program was successfully created.' }
        format.json { render action: 'show', status: :created, location: @program }
      else
        @contact.delete
        format.html { render action: 'new' }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to @program, notice: 'Program was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to programs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:name, :description, :start_date, :end_date, :cmu_facilities, :off_campus_facilities, :num_minors, :num_adults_supervising, :irb_approval, :contact_id, affiliations_attributes: [:id, :organization_id, :program_id, :description, :followed_process, :_destroy])
    end

    def contact_params
      params.require(:contact).permit(:title, :email, :street, :street2, :phone, :zip, :city, :state, :nickname, :notes)
    end
end
