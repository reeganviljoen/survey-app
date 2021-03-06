class QuestionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_question, except: %i[new create destroy]

  def new
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.new  
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @question = @survey.questions.new(question_params)

    if @question.save
      redirect_to edit_survey_path(@survey)
      flash.notice = 'Added question'
    else
      render :new, status: :unprocessable_entity
      flash.alert = 'Failed to add question'
    end
  end

  def update 
    if @question.update(question_params)
      redirect_to edit_survey_path(@question.survey)
      flash.notice = 'Updated question'
    else
      render :edit, status: :unprocessable_entity
      flash.alert = 'Failed to update question'
    end
  end
  
  def destroy
    @question = Question.find(params[:question_id])  

    @question.destroy
    redirect_to edit_survey_path(@question.survey), status: :see_other
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :question_type, :choice_1, :choice_2, :choice_3, :choice_4, :choice_5, :choice_6, :open_ended_answer, :multiple_answer_choice)
  end
end
