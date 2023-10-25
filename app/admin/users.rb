ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :password_digest, :email, :first_name, :last_name, :email_confirmed, :avatar
  #
  # or
  #
  # permit_params do
  #   permitted = [:password_digest, :email, :first_name, :last_name, :email_confirmed, :avatar]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
