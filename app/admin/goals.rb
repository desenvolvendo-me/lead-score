ActiveAdmin.register Goal do
  menu parent: I18n.t('active_admin.menu.management')
  permit_params :name, :description, :status

  index do
    id_column
    column :goal
    column :name
    column :description
    column :status
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :status
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
    f.actions
  end
end
