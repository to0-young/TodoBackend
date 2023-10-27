ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :email_confirmed, :avatar

  index do
    id_column
    column :email
    column :first_name
    column :last_name
    column :email_confirmed
    column :avatar
    actions
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :email_confirmed
      row :avatar
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :email_confirmed
      f.input :avatar, as: :file
    end
    f.actions
  end
end
