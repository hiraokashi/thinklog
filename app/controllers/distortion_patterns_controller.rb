class DistortionPatternsController < ApplicationController
  before_action :set_distortion_pattern, only: [:show, :edit, :update, :destroy]

  # GET /distortion_patterns
  # GET /distortion_patterns.json
  def index
    @distortion_patterns = DistortionPattern.all
  end

  # GET /distortion_patterns/1
  # GET /distortion_patterns/1.json
  def show
  end

  # GET /distortion_patterns/new
  def new
    @distortion_pattern = DistortionPattern.new
  end

  # GET /distortion_patterns/1/edit
  def edit
  end

  # POST /distortion_patterns
  # POST /distortion_patterns.json
  def create
    @distortion_pattern = DistortionPattern.new(distortion_pattern_params)

    respond_to do |format|
      if @distortion_pattern.save
        format.html { redirect_to @distortion_pattern, notice: 'Distortion pattern was successfully created.' }
        format.json { render :show, status: :created, location: @distortion_pattern }
      else
        format.html { render :new }
        format.json { render json: @distortion_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /distortion_patterns/1
  # PATCH/PUT /distortion_patterns/1.json
  def update
    respond_to do |format|
      if @distortion_pattern.update(distortion_pattern_params)
        format.html { redirect_to @distortion_pattern, notice: 'Distortion pattern was successfully updated.' }
        format.json { render :show, status: :ok, location: @distortion_pattern }
      else
        format.html { render :edit }
        format.json { render json: @distortion_pattern.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /distortion_patterns/1
  # DELETE /distortion_patterns/1.json
  def destroy
    @distortion_pattern.destroy
    respond_to do |format|
      format.html { redirect_to distortion_patterns_url, notice: 'Distortion pattern was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distortion_pattern
      @distortion_pattern = DistortionPattern.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distortion_pattern_params
      params.require(:distortion_pattern).permit(:cognitive_distortion_id, :distortion_pattern)
    end
end
