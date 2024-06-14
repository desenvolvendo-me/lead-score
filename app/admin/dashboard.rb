ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc {I18n.t("active_admin.dashboard")}

  content title: proc {I18n.t("active_admin.dashboard")} do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Bem Vindo ao Startup Mission"
      end
    end

    columns do
      column do
        panel "Recentes Metas Finalizadas" do
          ul do
            Goal.done.last(5).map do |goal|
              li link_to("#{goal.name}", admin_goal_path(goal))
            end
          end
        end
      end
      column do
        panel "Recentes Tarefas Finalizadas" do
          ul do
            Task.done.last(5).map do |task|
              li link_to("#{task.name}", admin_task_path(task))
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Tarefas Finalizadas por Mês" do
          render partial: 'admin/dashboards/tasks/finished_at_per_month'
        end
      end
    end

    columns do
      column do
        panel "Metas por Situação" do
          render partial: 'admin/dashboards/goals/per_status'
        end
      end
      column do
        panel "Tarefas por Situação" do
          render partial: 'admin/dashboards/tasks/per_status'
        end
      end
    end

  end
end