ActiveAdmin.register Task do
  menu parent: I18n.t('active_admin.menu.management')
  permit_params :name, :description, :status

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

  show title: proc { |task| task.name } do
    attributes_table do
      row :goal
      row :name
      row :description
      row :status do |task|
        status_tag I18n.t("enum.statuses.#{task.status}"),
                   class: task.status.to_s
      end
    end
  end

  form title: :name do |f|
    f.inputs do
      f.input :goal
      f.input :name
      f.input :description
      f.input :status, as: :select, collection: Task.statuses.keys.map { |key|
                                                  [I18n.t("enum.statuses.#{key}"), key]
                                                }
    end
    f.actions
  end
end
