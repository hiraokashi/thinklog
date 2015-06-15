class SituationsController < ApplicationController
  before_action :set_situation, only: [:show, :edit, :update, :destroy, :edit_modal]

  # GET /situations
  # GET /situations.json
  def index
    @situations = Situation.all
  end

  # GET /situations/1
  # GET /situations/1.json
  def show
  end

  # GET /situations/new
  def new
    @situation = Situation.new
  end

  # GET /situations/1/edit
  def edit
  end

  # POST /situations
  # POST /situations.json
  def create
    @situation = Situation.new(situation_params)

    respond_to do |format|
      if @situation.save

        params[:feelings_before].each do |id, percentage|
          #logger.debug("id= #{id}, percentage=#{percentage}")
          given_time_feeling = @situation.given_time_feelings.build(before_percentage: percentage, feeling: Feeling.find(id))
          @situation.given_time_feelings << given_time_feeling
        end
        #format.html { redirect_to @situation, notice: 'Situation was successfully created.' }
        format.html { redirect_to '/users/dashboard/1', notice: 'Situation was successfully created.' }
        format.json { render :show, status: :created, location: @situation }
      else
        format.html { render :new }
        format.json { render json: @situation.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_modal
    #ajaxでモーダルフォームをロードする
    @feelings = Feeling.all
    @feeling_ids = @situation.given_time_feelings.map { |given_time_feeling| given_time_feeling.feeling.id }
    render layout: false # レイアウトをなしにする場合
  end

  # PATCH/PUT /situations/1
  # PATCH/PUT /situations/1.json
  def update
    respond_to do |format|
      if @situation.update(situation_params)
        @situation.update_feeling_before(params[:feelings_before])
        format.html { redirect_to '/users/dashboard/1', notice: 'Situation was successfully created.' }
        #format.html { redirect_to @situation, notice: 'Situation was successfully updated.' }
        format.json { render :show, status: :ok, location: @situation }
      else
        format.html { render :edit }
        format.json { render json: @situation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /situations/1
  # DELETE /situations/1.json
  def destroy
    @situation.destroy
    respond_to do |format|
      format.html { redirect_to situations_url, notice: 'Situation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_situation
      @situation = Situation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def situation_params
      params.require(:situation).permit(:when, :where, :with_whom, :what_have_you_been_doing, :user_id)
    end


end
