class Question < ApplicationRecord
  belongs_to :survey
  
   def next
    Question.where("id > ?", id).first
   end

   def previous
    Question.where("id < ?", id).last
   end
end
