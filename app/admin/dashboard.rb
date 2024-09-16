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
    end
  end
end