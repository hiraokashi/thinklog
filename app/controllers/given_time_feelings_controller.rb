class GivenTimeFeelingsController < ApplicationController
  before_action :set_given_time_feeling, only: [:show, :edit, :update, :destroy]

  # GET /given_time_feelings
  # GET /given_time_feelings.json
  def index
    @given_time_feelings = GivenTimeFeeling.all
  end

  # GET /given_time_feelings/1
  # GET /given_time_feelings/1.json
  def show
  end

  # GET /given_time_feelings/new
  def new
    @given_time_feeling = GivenTimeFeeling.new
  end

  # GET /given_time_feelings/1/edit
  def edit
  end

  # POST /given_time_feelings
  # POST /given_time_feelings.json
  def create
    @given_time_feeling = GivenTimeFeeling.new(given_time_feeling_params)

    respond_to do |format|
      if @given_time_feeling.save
        format.html { redirect_to @given_time_feeling, notice: 'Given time feeling was successfully created.' }
        format.json { render :show, status: :created, location: @given_time_feeling }
      else
        format.html { render :new }
        format.json { render json: @given_time_feeling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /given_time_feelings/1
  # PATCH/PUT /given_time_feelings/1.json
  def update
    respond_to do |format|
      if @given_time_feeling.update(given_time_feeling_params)
        format.html { redirect_to @given_time_feeling, notice: 'Given time feeling was successfully updated.' }
        format.json { render :show, status: :ok, location: @given_time_feeling }
      else
        format.html { render :edit }
        format.json { render json: @given_time_feeling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /given_time_feelings/1
  # DELETE /given_time_feelings/1.json
  def destroy
    @given_time_feeling.destroy
    respond_to do |format|
      format.html { redirect_to given_time_feelings_url, notice: 'Given time feeling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_given_time_feeling
      @given_time_feeling = GivenTimeFeeling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def given_time_feeling_params
      params.require(:given_time_feeling).permit(:feeling_id, :situation_id)
    end
end
