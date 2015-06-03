class AdaptiveThoughtsController < ApplicationController
  before_action :set_adaptive_thought, only: [:show, :edit, :update, :destroy]

  # GET /adaptive_thoughts
  # GET /adaptive_thoughts.json
  def index
    @adaptive_thoughts = AdaptiveThought.all
  end

  # GET /adaptive_thoughts/1
  # GET /adaptive_thoughts/1.json
  def show
  end

  # GET /adaptive_thoughts/new
  def new
    @adaptive_thought = AdaptiveThought.new
  end

  # GET /adaptive_thoughts/1/edit
  def edit
  end

  # POST /adaptive_thoughts
  # POST /adaptive_thoughts.json
  def create
    @adaptive_thought = AdaptiveThought.new(adaptive_thought_params)

    respond_to do |format|
      if @adaptive_thought.save
        format.html { redirect_to @adaptive_thought, notice: 'Adaptive thought was successfully created.' }
        format.json { render :show, status: :created, location: @adaptive_thought }
      else
        format.html { render :new }
        format.json { render json: @adaptive_thought.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adaptive_thoughts/1
  # PATCH/PUT /adaptive_thoughts/1.json
  def update
    respond_to do |format|
      if @adaptive_thought.update(adaptive_thought_params)
        format.html { redirect_to @adaptive_thought, notice: 'Adaptive thought was successfully updated.' }
        format.json { render :show, status: :ok, location: @adaptive_thought }
      else
        format.html { render :edit }
        format.json { render json: @adaptive_thought.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adaptive_thoughts/1
  # DELETE /adaptive_thoughts/1.json
  def destroy
    @adaptive_thought.destroy
    respond_to do |format|
      format.html { redirect_to adaptive_thoughts_url, notice: 'Adaptive thought was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adaptive_thought
      @adaptive_thought = AdaptiveThought.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adaptive_thought_params
      params.require(:adaptive_thought).permit(:contents, :automatic_thought_id)
    end
end
