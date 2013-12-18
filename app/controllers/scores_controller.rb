class ScoresController < ApplicationController
  layout 'simple'
  def index
  end

  def show
    @score = Score.find(params[:id])
  end

  def new
    @conference = User.find(1).conference
    @score = Score.new

    @teams = team_gen(@conference.number_of_team)
    @scores = score_gen(@conference.max_score)
  end

  def create
    @score = Score.new(score_params)
    @score.conference = User.find(1).conference
    @score.save
    respond_to do |format|
      if @score.save
        format.html { redirect_to @score, notice: 'Score was successfully created.' }
      else
        @conference = User.find(1).conference

        @teams = team_gen(@conference.number_of_team)
        @scores = score_gen(@conference.max_score)

        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    redirect_to controller: 'admin', action: 'scores'
  end

  private
  def score_params
    params.require(:score).permit(:user_name, :selected_team, :score)
  end

  def team_gen(number_of_team)
    array = Array.new(number_of_team) 
    for i in 0...number_of_team
      array[i] = [];
      array[i][0] = (i+1).to_s + "팀"
      array[i][1] = i+1
    end
    array
  end

  def score_gen(max_score)
    array = Array.new(max_score)
    for i in 1..max_score
      array[i] = i
    end
    array
  end

end
