class UsersController < ApplicationController

  	def show
  		@users = User.where.not(id: current_user.id)
  		@user = User.find_by_id(current_user.id)
	end

	def withdraw_money
		@user = User.find_by_id(params[:id])
	end

	def after_withdraw_money
		amount = current_user.wallet
		if params[:wallet].to_f <= amount
			amount -= params[:wallet].to_f
			current_user.update_attributes(:wallet => amount)
			Transaction.create(user_id: current_user.id, amount: params[:wallet].to_f, transaction_type: "wallet withdraw money", transaction_note: "#{amount} minus by #{params[:wallet].to_f}")
			flash[:notice] = "your wallet amount is debited!"
			redirect_to user_path(current_user.id)
		else
			flash[:alert] = "Alerting...... its not possible"
			redirect_to user_withdraw_money_path(:id => current_user.id)
		end
	end

	
	def transfer_to_another_user
		@user = User.find_by_id(params[:id])
		@users = User.where.not(id: params[:id])
	end

	def after_transfer_to_another_user
		@user = User.find_by_id(params[:transfer_to_user])
		amount = current_user.wallet
		if params[:wallet].to_f <= amount
			amount -= params[:wallet].to_f
			current_user.update_attributes(:wallet => amount)
			@user.update_attributes(:wallet => (@user.wallet + params[:wallet].to_f))
			Transaction.create(user_id: current_user.id, amount: params[:wallet].to_f, transaction_type: "transfer_to another user money", transaction_note: "#{amount} minus by #{params[:wallet].to_f}")
			flash[:notice] = "your wallet amount is debited!"
			redirect_to user_path(current_user.id)
		else
			flash[:alert] = "Alerting...... its not possible"
			redirect_to user_transfer_to_another_user_path(:id => current_user.id)
		end
	end

	def transaction_reports
		@transaction = Transaction.where(user_id: params[:id])
	end
end
