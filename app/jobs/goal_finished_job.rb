class GoalFinishedJob < ApplicationJob
  queue_as :low_priority

  def perform(goal)
    Goals::Finisher.call(goal)
  end
end
