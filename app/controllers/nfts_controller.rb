require 'SecureRandom'
class NftsController < ApplicationController
  before_action :set_nft, only: %i[edit update destroy ]
  def produce_token(length=32)
    token = SecureRandom.urlsafe_base64(length)
  end
  # GET /nfts or /nfts.json
  def index
    @nfts = Nft.all
  end

  # GET /nfts/1 or /nfts/1.json
  def show
    @nft = Nft.find_by(nft_id: params[:id])
  end

  # GET /nfts/new
  def new
    @nft = Nft.new
  end

  # GET /nfts/1/edit
  def edit
  end

  # POST /nfts or /nfts.json
  def create
    @nft = Nft.new(nft_params)
    @nft[:nft_id] = produce_token
    respond_to do |format|
      if @nft.save
        format.html { redirect_to nft_url(@nft[:nft_id]), notice: "Nft was successfully created." }
        format.json { render :show, status: :created, location: @nft[:nft_id] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nfts/1 or /nfts/1.json
  def update
    respond_to do |format|
      if @nft.update(nft_params)
        format.html { redirect_to nft_url(@nft), notice: "Nft was successfully updated." }
        format.json { render :show, status: :ok, location: @nft }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nfts/1 or /nfts/1.json
  def destroy
    @nft.destroy

    respond_to do |format|
      format.html { redirect_to nfts_url, notice: "Nft was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nft
      @nft = Nft.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nft_params
      params.require(:nft).permit(:token_link, :nft_id, :owner_name, :wallet_address)
    end
end
