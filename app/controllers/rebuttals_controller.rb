class RebuttalsController < ApplicationController
  before_action :set_rebuttal, only: [:show, :edit, :update, :destroy]

  # GET /rebuttals
  # GET /rebuttals.json
  def index
    @rebuttals = Rebuttal.all
  end

  # GET /rebuttals/1
  # GET /rebuttals/1.json
  def show
  end

  # GET /rebuttals/new
  def new
    @rebuttal = Rebuttal.new
  end

  # GET /rebuttals/1/edit
  def edit
  end

  # POST /rebuttals
  # POST /rebuttals.json
  def create
    @rebuttal = Rebuttal.new(rebuttal_params)

    respond_to do |format|
      if @rebuttal.save
        format.html { redirect_to @rebuttal, notice: 'Rebuttal was successfully created.' }
        format.json { render :show, status: :created, location: @rebuttal }
      else
        format.html { render :new }
        format.json { render json: @rebuttal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rebuttals/1
  # PATCH/PUT /rebuttals/1.json
  def update
    respond_to do |format|
      if @rebuttal.update(rebuttal_params)
        format.html { redirect_to @rebuttal, notice: 'Rebuttal was successfully updated.' }
        format.json { render :show, status: :ok, location: @rebuttal }
      else
        format.html { render :edit }
        format.json { render json: @rebuttal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rebuttals/1
  # DELETE /rebuttals/1.json
  def destroy
    @rebuttal.destroy
    respond_to do |format|
      format.html { redirect_to rebuttals_url, notice: 'Rebuttal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rebuttal
      @rebuttal = Rebuttal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rebuttal_params
      params.require(:rebuttal).permit(:contents, :automatic_thought_id)
    end
end
