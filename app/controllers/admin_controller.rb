class AdminController < ApplicationController
  before_filter :authenticate_user!
  def preference 
    @conference = current_user.conference
  end
  
  def statistic
    @conference = current_user.conference
    @number_of_team = @conference.number_of_team
    
    @scores = Score.all
    @avg_score = Array.new(@number_of_team) {Array.new(3)}

    for i in 0...@number_of_team
      @avg_score[i][0] = (i+1).to_s + "팀"
      @scores_for_team_i = @scores.find_all_by_selected_team(i+1)
      @avg_score[i][1] = @scores_for_team_i.count

      @sum = @scores_for_team_i.inject(0){|result, element| result+element.score}
      if @avg_score[i][1] == 0
        @avg_score[i][2] = 0
      else
        @avg_score[i][2] = @sum.to_f/@avg_score[i][1].to_f
        @avg_score[i][2] = (@avg_score[i][2]*100).round / 100.0  
      end
    end
  end

  def scores
    @scores = Score.all
  end

  def edit
    @conference = current_user.conference
  end

  def update
    @conference = current_user.conference  

    respond_to do |format|
      if @conference.update_attributes(conference_params)
        format.html { redirect_to action: "preference"}
      else
        format.html { render action: "edit" }
      end
    end

  end

  def delete_all_scores
    Score.delete_all
    redirect_to action: "statistic"
  end

  private
  def conference_params
    params.require(:conference).permit(:id, :name, :number_of_team, :max_score)
  end
end
