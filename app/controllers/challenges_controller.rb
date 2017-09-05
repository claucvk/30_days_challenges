class ChallengesController < OpenReadController
  before_action :set_challenge, only: [:show, :update, :destroy]

  # GET /challenges
  def index
    @challenges = Challenge.find_by(user_id: params[:user_id])

    render json: @challenges
end

  # GET /challenges/1
  def show
    render json: @challenge
  end

  # POST /challenges
  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      render json: @challenge, status: :created, location: @challenge
    else
      puts @challenge
      render json: @challenge.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /challenges/1
  def update
    @user = User.find(params[:id])
    @id = params[:challenge][:id]
    @challenge = @user.challenges.find(@id)
   @challenge.update(challenge_params)
    #if @challenge.update(challenge_params)
    #  render json: @challenge
    #else
    #  render json: @challenge.errors, status: :unprocessable_entity
    #end
  end

  # DELETE /challenges/1
  def destroy
    @user = User.find(params[:id])
    @id = params[:challenge][:id]
    @challenge = @user.challenges.find(@id)
    @challenge.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def challenge_params
      params.require(:challenge).permit(:name, :goal, :start_day, :end_day, :status, :user_id)
    end
end
