require 'json'
require 'stripe'
class IndicesController < ApplicationController
  before_action :set_index, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [ :webhook, :create_customer ]

  def webhook
    endpoint_secret = 'whsec_Y98HMTMiOdOitxwzIe82fVZJOyWbxBRs';
    payload = request.body.read
    event = nil

    begin
      event = Stripe::Event.construct_from(
        JSON.parse(payload, symbolize_names: true)
      )
    rescue JSON::ParserError => e
      # Invalid payload
      puts "⚠️  Webhook error while parsing basic request. #{e.message})"
      status 400
      return
    end
    # Check if webhook signing is configured.
    if endpoint_secret
      # Retrieve the event by verifying the signature using the raw body and secret.
      signature = request.env['HTTP_STRIPE_SIGNATURE'];
      begin
        event = Stripe::Webhook.construct_event(
          payload, signature, endpoint_secret
        )
      rescue Stripe::SignatureVerificationError
        puts "⚠️  Webhook signature verification failed. #{err.message})"
        status 400
      end
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object # contains a Stripe::PaymentIntent
      puts "Payment for #{payment_intent['amount']} succeeded."
      # Then define and call a method to handle the successful payment intent.
      # handle_payment_intent_succeeded(payment_intent)
    when 'payment_method.attached'
      payment_method = event.data.object # contains a Stripe::PaymentMethod
      # Then define and call a method to handle the successful attachment of a PaymentMethod.
      # handle_payment_method_attached(payment_method)
    else
      puts "Unhandled event type: #{event.type}"
    end

    # Handle the event
    case event.type
    when 'charge.captured'
        charge = event.data.object
    when 'charge.succeeded'
        charge = event.data.object
        Customer.find_by(email: event.data.object["billing_details"]["email"])
    when 'charge.dispute.funds_reinstated'
        dispute = event.data.object
    when 'checkout.session.async_payment_failed'
        session = event.data.object
    when 'checkout.session.async_payment_succeeded'
        session = event.data.object
    # ... handle other event types
    else
        puts "Unhandled event type: #{event.type}"
    end
    status
  end
  # GET /indices or /indices.json

  def index
    @indices = Index.all
  end

  def create_customer
    @customer = Customer.new(first_name: params[:First_Name], email: params[:Email_Address], linked_in_profile: params[:linked_in_profile], image: params[:images])
    @customer.save
    redirect_to "https://buy.stripe.com/eVa5lf4CB5HKfNC4gg", allow_other_host: true
  end

  # GET /indices/1 or /indices/1.json
  def show
    # Set your secret key. Remember to switch to your live secret key in production.
    # See your keys here: https://dashboard.stripe.com/apikeys
  Stripe.api_key = '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'

  Stripe::Customer.create(description: 'My First Test Customer', first_name: "josh", last_name: "bond")
  end

  # GET /indices/new
  def new
    @index = Index.new
  end

  # GET /indices/1/edit
  def edit
  end

  # POST /indices or /indices.json
  def create
    @index = Index.new(index_params)

    respond_to do |format|
      if @index.save
        format.html { redirect_to index_url(@index), notice: "Index was successfully created." }
        format.json { render :show, status: :created, location: @index }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /indices/1 or /indices/1.json
  def update
    respond_to do |format|
      if @index.update(index_params)
        format.html { redirect_to index_url(@index), notice: "Index was successfully updated." }
        format.json { render :show, status: :ok, location: @index }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /indices/1 or /indices/1.json
  def destroy
    @index.destroy

    respond_to do |format|
      format.html { redirect_to indices_url, notice: "Index was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_index
      @index = Index.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def index_params
      params.fetch(:index, {})
    end
end
