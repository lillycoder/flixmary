class Instructor::LessonsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :require_authorized_for_current_section, only: [:create]
  before_action :require_authorized_for_current_lesson, only: [:update]

  def create
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
  end

  def update
    current_lesson.update_attributes(lesson_params)
    render plain: 'updated'
  end

  private

    def require_authorized_for_current_lesson
      if current_lesson.section.course.user != current_user
        render plain: 'Unauthorized', status: :unauthroized
      end
    end

    def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
    end

    def require_authorized_for_current_section
      if current_section.course.user != current_user
        return render plain: 'Unauthorized', status: :Unauthorized
      end
    end
    
    helper_method :current_section

    def current_section
      @current_setion ||= Section.find(params[:section_id])
    end

    def lesson_params
      params.require(:lesson).permit(:name, :title, :subtitle, :video, :row_order_position)
    end

end
