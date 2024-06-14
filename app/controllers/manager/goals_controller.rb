module Manager
  class GoalsController < InternalController
    before_action :set_goal, only: %i[show edit update destroy]

    def index
      @q = Goal.ransack(params[:q])
      @goals = @q.result(distinct: true)
      @goals = @goals.order('created_at').page(params[:page]).per(4)
    end

    def show; end

    def new
      @goal = Goal.new
      @goal.tasks.build
    end

    def edit; end

    def create
      @goal = Goal.new(goal_params)
      @goal.client = current_user.client

      respond_to do |format|
        if @goal.save
          format.html do
            redirect_to manager_goal_path(@goal),
                        notice: t('.create')
          end
        else
          format.html do
            render :new,
                   status: :unprocessable_entity
          end
        end
      end
    end

    def update
      respond_to do |format|
        if @goal.update(goal_params)
          format.html do
            redirect_to manager_goal_path(@goal),
                        notice: t('.update')
          end
        else
          format.html do
            render :edit,
                   status: :unprocessable_entity
          end
        end
      end
    end

    def destroy
      @goal.destroy
      respond_to do |format|
        format.html do
          redirect_to manager_goals_path,
                      notice: t('.destroy')
        end
      end
    end

    private

    def goal_params
      params.require(:goal).permit(:name,
                                   :description, :status,
                                   tasks_attributes:
                                     %i[id name description status _destroy])
    end

    def set_goal
      @goal = Goal.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to(manager_goals_path, alert: 'Goal not found')
    end
  end
end
