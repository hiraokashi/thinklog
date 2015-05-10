class CognitiveDistortionsController < ApplicationController
  before_action :set_cognitive_distortion, only: [:show, :edit, :update, :destroy]

  # GET /cognitive_distortions
  # GET /cognitive_distortions.json
  def index
    @cognitive_distortions = CognitiveDistortion.all
  end

  # GET /cognitive_distortions/1
  # GET /cognitive_distortions/1.json
  def show
  end

  # GET /cognitive_distortions/new
  def new
    @cognitive_distortion = CognitiveDistortion.new
  end

  # GET /cognitive_distortions/1/edit
  def edit
  end

  # POST /cognitive_distortions
  # POST /cognitive_distortions.json
  def create
    @cognitive_distortion = CognitiveDistortion.new(cognitive_distortion_params)

    respond_to do |format|
      if @cognitive_distortion.save
        format.html { redirect_to @cognitive_distortion, notice: 'Cognitive distortion was successfully created.' }
        format.json { render :show, status: :created, location: @cognitive_distortion }
      else
        format.html { render :new }
        format.json { render json: @cognitive_distortion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cognitive_distortions/1
  # PATCH/PUT /cognitive_distortions/1.json
  def update
    respond_to do |format|
      if @cognitive_distortion.update(cognitive_distortion_params)
        format.html { redirect_to @cognitive_distortion, notice: 'Cognitive distortion was successfully updated.' }
        format.json { render :show, status: :ok, location: @cognitive_distortion }
      else
        format.html { render :edit }
        format.json { render json: @cognitive_distortion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cognitive_distortions/1
  # DELETE /cognitive_distortions/1.json
  def destroy
    @cognitive_distortion.destroy
    respond_to do |format|
      format.html { redirect_to cognitive_distortions_url, notice: 'Cognitive distortion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cognitive_distortion
      @cognitive_distortion = CognitiveDistortion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cognitive_distortion_params
      params.require(:cognitive_distortion).permit(:question, :name)
    end
end
