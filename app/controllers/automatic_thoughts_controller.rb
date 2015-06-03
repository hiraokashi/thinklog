class AutomaticThoughtsController < ApplicationController
  before_action :set_automatic_thought, only: [:show, :edit, :update, :destroy]

  # GET /automatic_thoughts
  # GET /automatic_thoughts.json
  def index
    @automatic_thoughts = AutomaticThought.all
  end

  # GET /automatic_thoughts/1
  # GET /automatic_thoughts/1.json
  def show
  end

  # GET /automatic_thoughts/new
  def new
    @automatic_thought = AutomaticThought.new
  end

  # GET /automatic_thoughts/1/edit
  def edit
  end

  # POST /automatic_thoughts
  # POST /automatic_thoughts.json
  def create
    @automatic_thought = AutomaticThought.new(automatic_thought_params)

    respond_to do |format|
      if @automatic_thought.save
        format.html { redirect_to @automatic_thought, notice: 'Automatic thought was successfully created.' }
        format.json { render :show, status: :created, location: @automatic_thought }
      else
        format.html { render :new }
        format.json { render json: @automatic_thought.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /automatic_thoughts/1
  # PATCH/PUT /automatic_thoughts/1.json
  def update
    respond_to do |format|
      if @automatic_thought.update(automatic_thought_params)
        format.html { redirect_to @automatic_thought, notice: 'Automatic thought was successfully updated.' }
        format.json { render :show, status: :ok, location: @automatic_thought }
      else
        format.html { render :edit }
        format.json { render json: @automatic_thought.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /automatic_thoughts/1
  # DELETE /automatic_thoughts/1.json
  def destroy
    @automatic_thought.destroy
    respond_to do |format|
      format.html { redirect_to automatic_thoughts_url, notice: 'Automatic thought was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_automatic_thought
      @automatic_thought = AutomaticThought.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def automatic_thought_params
      params.require(:automatic_thought).permit(:contents, :given_time_feeling_id)
    end
end
