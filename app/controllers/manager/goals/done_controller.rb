module Manager
  module Goals
    class DoneController < InternalController
      before_action :set_goal,
                    only: %i[index show]

      def index
        @goal.done!
        respond_to do |format|
          format.html do
            redirect_to manager_goals_path,
                        notice: t('.other')
          end
        end
      end

      def show
        @goal.done!
        respond_to do |format|
          format.html do
            redirect_to manager_goal_path(@goal),
                        notice: t('.one')
          end
        end
      end

      def many
        Goal.where(id: params[:done][:goal_ids])
            .update(status: :done)

        respond_to do |format|
          format.json do
            render json: { message: t('.other') },
                   status: :ok
          end
        end
      end

      private

      def set_goal
        @goal = Goal.find(params[:goal_id])
      end
    end
  end
end
