class AdultChildrenTraitsController < ApplicationController
  before_action :set_adult_children_trait, only: [:show, :edit, :update, :destroy]

  # GET /adult_children_traits
  # GET /adult_children_traits.json
  def index
    @adult_children_traits = AdultChildrenTrait.all
  end

  # GET /adult_children_traits/1
  # GET /adult_children_traits/1.json
  def show
  end

  # GET /adult_children_traits/new
  def new
    @adult_children_trait = AdultChildrenTrait.new
  end

  # GET /adult_children_traits/1/edit
  def edit
  end

  # POST /adult_children_traits
  # POST /adult_children_traits.json
  def create
    @adult_children_trait = AdultChildrenTrait.new(adult_children_trait_params)

    respond_to do |format|
      if @adult_children_trait.save
        format.html { redirect_to @adult_children_trait, notice: 'Adult children trait was successfully created.' }
        format.json { render :show, status: :created, location: @adult_children_trait }
      else
        format.html { render :new }
        format.json { render json: @adult_children_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adult_children_traits/1
  # PATCH/PUT /adult_children_traits/1.json
  def update
    respond_to do |format|
      if @adult_children_trait.update(adult_children_trait_params)
        format.html { redirect_to @adult_children_trait, notice: 'Adult children trait was successfully updated.' }
        format.json { render :show, status: :ok, location: @adult_children_trait }
      else
        format.html { render :edit }
        format.json { render json: @adult_children_trait.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adult_children_traits/1
  # DELETE /adult_children_traits/1.json
  def destroy
    @adult_children_trait.destroy
    respond_to do |format|
      format.html { redirect_to adult_children_traits_url, notice: 'Adult children trait was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adult_children_trait
      @adult_children_trait = AdultChildrenTrait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adult_children_trait_params
      params.require(:adult_children_trait).permit(:contents)
    end
end
