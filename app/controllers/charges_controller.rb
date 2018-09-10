class ChargesController < ApplicationController
  before_action :authenticate_user!

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, #Note -- this is NOT the user_id in the app
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )


    flash[:notice] = "Thanks for all the money, #{current_user.email}! Now you are a PREMIUM member!."
    current_user.update_attribute(:role, 'premium')

    redirect_to root_path # or wherever



    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def downgrade

    current_user.update_attribute(:role, 'standard')
    flash[:notice] = "You've changed your mind, #{current_user.email}! Your account have beed downgraded to STANDARD!."


    redirect_to new_charge_path
  end

end
