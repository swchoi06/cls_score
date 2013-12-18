class Score < ActiveRecord::Base
  belongs_to :conference

  validates :user_name, format: { with: /20[0-9][0-9]-[0-9][0-9][0-9][0-9][0-9]/, message: "학번 형식을 제대로 기입해주세요. ex) 2012-xxxxx"}
  validates_uniqueness_of :user_name, :scope => :selected_team, message: "해당 팀에 대하여 이미 투표를 마치셨습니다."
  validates :score, presence:{message: "점수는 비워둘 수 없습니다"} 
end
