module Api
  module Goals
    class DoneController < ApiController
      before_action :set_goal,
                    only: %i[index show]

      def index
        @goal.done!
      end

      def show
        @goal.done!
      end

      def many
        @goals = Goal.where(id: params[:goal_ids])

        if @goals.any?
          @goals.update(status: :done)
        else
          render json: { error: "Couldn't find Goals" }, status: :not_found
        end
      end

      private

      def set_goal
        @goal = Goal.find(params[:goal_id])
      end
    end
  end
end
