class ApplicationController < ActionController::Base
  # コントローラーアクション実行前に対象メソッﾄﾞを実行（パラメーターの許可）
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

   protected

  # ユーザー登録(sign_up)の際にユーザー名(name)とemailデータ操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
