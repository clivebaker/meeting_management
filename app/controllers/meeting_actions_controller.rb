class MeetingActionsController < ApplicationController
  before_action :set_business_unit
  before_action :set_meeting
  before_action :set_meeting_action, only: %i[ show edit update destroy ]
  before_action :set_users

  # GET /meeting_actions or /meeting_actions.json
  def index
    @meeting_actions = MeetingAction.where(meeting_id: @meeting.id)
  end

  # GET /meeting_actions/1 or /meeting_actions/1.json
  def show
  end

  # GET /meeting_actions/new
  def new
    @meeting_action = MeetingAction.new
    @meeting_action.meeting_id = @meeting.id
  end

  # GET /meeting_actions/1/edit
  def edit
  end

  # POST /meeting_actions or /meeting_actions.json
  def create
    @meeting_action = MeetingAction.new(meeting_action_params)

    respond_to do |format|
      if @meeting_action.save
        format.html { redirect_to business_unit_meeting_meeting_action_url(@business_unit, @meeting, @meeting_action), notice: "Meeting action was successfully created." }
        format.json { render :show, status: :created, location: @meeting_action }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting_action.errors, status: :unprocessable_entity }
      end
    end
  end



  def complete

    @meeting_action = MeetingAction.find(params[:meeting_action_id])
    @meeting_action.close! if @meeting_action.may_close? 
   
    respond_to do |format|
        format.html { redirect_to business_unit_meeting_meeting_actions_url(@business_unit, @meeting), notice: "Item was successfully closed." }
    end



  end


  # PATCH/PUT /meeting_actions/1 or /meeting_actions/1.json
  def update
    respond_to do |format|
      if @meeting_action.update(meeting_action_params)
        format.html { redirect_to business_unit_meeting_meeting_action_url(@business_unit, @meeting, @meeting_action), notice: "Meeting action was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting_action }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_actions/1 or /meeting_actions/1.json
  def destroy
    @meeting_action.destroy

    respond_to do |format|
      format.html { redirect_to business_unit_meeting_meeting_actions_url(@business_unit, @meeting), notice: "Meeting action was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  def move

    @meeting_action = MeetingAction.find(params[:meeting_action_id])
    direction = params[:direction]
    if direction == 'up'
      @meeting_action.move_higher
    else
      @meeting_action.move_lower
    end

    respond_to do |format|
        format.html { redirect_to business_unit_meeting_meeting_actions_url(@business_unit, @meeting), notice: "Action was successfully moved." }
    end



  end



  private

    def set_users 

      @users = User.joins(:business_unit_users).where('business_unit_users.business_unit_id = ?', @business_unit.id)

    end

    def set_business_unit
      @business_unit = BusinessUnit.find(params[:business_unit_id])
    end
    def set_meeting
      @meeting = Meeting.find(params[:meeting_id])
    end
# Use callbacks to share common setup or constraints between actions.
    def set_meeting_action
      @meeting_action = MeetingAction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_action_params
      params.require(:meeting_action).permit(:meeting_id, :name, :note, :user_id)
    end
end
