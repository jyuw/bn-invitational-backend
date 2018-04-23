class Result < ApplicationRecord
  belongs_to :athlete, dependent: :destroy

  def updated_votes(params)
    self.rating_collection << params[:vote].to_i
    self.score = (self.rating_collection.sum) / (self.rating_collection.length)
    self.score.round(2)
    self.number_of_votes = self.rating_collection.length
    self.save
  end

  def self.publish_results
    all.each do |result|
      result.has_raced = true
      result.save
    end
  end

  def self.revert_results
    all.each do |result|
      result.has_raced = false
      result.save
    end
  end
end
