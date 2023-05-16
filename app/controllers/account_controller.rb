class AccountController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to account_path, notice: 'Vous avez mis à jour votre date de début du mois avec succès.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:monthly_debit_date)
  end
end
