ActiveAdmin.register Goal do
  menu parent: I18n.t('active_admin.menu.management')
  permit_params :name, :description, :status,
                tasks_attributes: %i[id name status description _destroy]

  index do
    id_column
    column :goal
    column :name
    column :description
    column :status do |task|
      status_tag I18n.t("enum.statuses.#{task.status}"), class: task.status.to_s
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :status do |task|
        status_tag I18n.t("enum.statuses.#{task.status}"),
                   class: task.status.to_s
      end
    end

    panel I18n.t('active_admin.goal.tasks') do
      table_for goal.tasks do
        column :name
        column :description
        column :status do |task|
          status_tag I18n.t("enum.statuses.#{task.status}"),
                     class: task.status.to_s
        end
      end
    end
  end

  form do |f|
    f.inputs I18n.t('activerecord.models.goal.one') do
      f.input :name
      f.input :description
      f.input :status, as: :select, collection: Goal.statuses.keys.map { |key|
                                                  [I18n.t("enum.statuses.#{key}"), key]
                                                }
    end

    f.inputs I18n.t('active_admin.goal.task.nested') do
      f.has_many :tasks, allow_destroy: true,
                         heading: I18n.t('active_admin.goal.tasks') do |task|
        task.input :name
        task.input :description
        task.input :status, as: :select, collection: Task.statuses.keys.map { |key|
                                                       [I18n.t("enum.statuses.#{key}"), key]
                                                     }
      end
    end

    f.actions
  end
end
