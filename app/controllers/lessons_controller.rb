class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show] 


  def show
  end

  private

  def require_authorized_for_current_lesson
    if current_user.enrolled_in?(current_lesson.section.course) != true
      redirect_to course_path_url, alert: 'To view the Lessons in this course you need to first Enroll in the Course - Thank you'     
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
