module Goals
  class Finisher < BusinessApplication
    def initialize(goal)
      @goal = goal
    end

    def call
      return unless @goal.done?

      done_all_tasks
      send_mailer
    end

    private

    def send_mailer
      # TODO: Adicionar devise
      GoalMailer.with(user: '').finished.deliver_later
    end

    def done_all_tasks
      @goal.tasks.update(status: :done)
    end
  end
end
