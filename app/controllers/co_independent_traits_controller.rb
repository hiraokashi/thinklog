class CoIndependentTraitsController < ApplicationController
  before_action :set_co_independent_trait, only: [:show, :edit, :update, :destroy]

  # GET /co_independent_traits
  # GET /co_independent_traits.json
  def index
    @co_independent_traits = CoIndependentTrait.all
  end

  # GET /co_independent_traits/1
  # GET /co_independent_traits/1.json
  def show
  end

  # GET /co_independent_traits/new
  def new
    @co_independent_trait = CoIndependentTrait.new
  end

  # GET /co_independent_traits/1/edit
  def edit
  end

  # POST /co_independent_traits
  # POST /co_independent_traits.json
  def create
    @co_independent_trait = CoIndependentTrait.new(co_independent_trait_params)

    respond_to do |format|
      if @co_independent_trait.save
        format.html { redirect_to @co_independent_trait, notice: 'Co independent trait was successfully created.' }
        format.json { render :show, status: :created, location: @co_independent_trait }
      else
        format.html { render :new }
        format.json { render json: @co_independent_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /co_independent_traits/1
  # PATCH/PUT /co_independent_traits/1.json
  def update
    respond_to do |format|
      if @co_independent_trait.update(co_independent_trait_params)
        format.html { redirect_to @co_independent_trait, notice: 'Co independent trait was successfully updated.' }
        format.json { render :show, status: :ok, location: @co_independent_trait }
      else
        format.html { render :edit }
        format.json { render json: @co_independent_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /co_independent_traits/1
  # DELETE /co_independent_traits/1.json
  def destroy
    @co_independent_trait.destroy
    respond_to do |format|
      format.html { redirect_to co_independent_traits_url, notice: 'Co independent trait was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_co_independent_trait
      @co_independent_trait = CoIndependentTrait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def co_independent_trait_params
      params.require(:co_independent_trait).permit(:contents)
    end
end
