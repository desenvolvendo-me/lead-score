module Goals
  class Finisher < BusinessApplication
    def initialize(goal)
      @goal = goal
    end

    def call
      return unless @goal.done?

      send_mailer
    end

    private

    def send_mailer
      # TODO: Adicionar devise
      GoalMailer.with(user: '').finished.deliver_later
    end
  end
end
