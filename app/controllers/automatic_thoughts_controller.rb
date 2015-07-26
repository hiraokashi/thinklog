class AutomaticThoughtsController < ApplicationController
  before_action :set_automatic_thought, only: [:show, :edit, :update, :destroy, :update_basis_and_rebuttal, :update_adaptive_thought, :think, :think_deeply, :think_adaptively, :progress_finished]

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
    #step2実行結果の保存
    respond_to do |format|
      if @automatic_thought.update(automatic_thought_params)
        @automatic_thought.update_distortion(params[:distortion_pattern])
        @automatic_thought.given_time_feeling.update_percentage(params[:feelings])
        format.html { redirect_to @automatic_thought, notice: 'Automatic thought was successfully updated.' }
        format.json { render :show, status: :ok, location: @automatic_thought }
      else
        format.html { render :edit }
        format.json { render json: @automatic_thought.errors, status: :unprocessable_entity }
      end
    end
  end

  #Step3の実行結果更新
  def update_basis_and_rebuttal
    respond_to do |format|
      if @automatic_thought.update_basis_and_rebuttal(params[:basis], params[:rebuttal])
        @automatic_thought.given_time_feeling.update_percentage(params[:feelings])
        format.html { redirect_to @automatic_thought, notice: 'Automatic thought was successfully updated.' }
        format.json { render :show, status: :ok, location: @automatic_thought }
      else
        format.html { render :edit }
        format.json { render json: @automatic_thought.errors, status: :unprocessable_entity }
      end
    end

  end

  #step4の実行結果更新
  def update_adaptive_thought
    respond_to do |format|
      if @automatic_thought.update_adaptive_thought(params[:adaptive_thought])
        @automatic_thought.given_time_feeling.update_percentage(params[:feelings])
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

  # GET
  def think
    #step2の実行
    @user = current_user
    @cognitive_distortions = CognitiveDistortion.all
    @distortion_ids = @automatic_thought.distortion_patterns.map {|distortion_pattern| distortion_pattern.cognitive_distortion.id}
    @automatic_thought.given_time_feeling.progress_step_2() #状態管理

  end

  #GET
  #根拠と反証
  def think_deeply
    #step3の実行

    @user = current_user
    @automatic_thought.given_time_feeling.progress_step_3() #状態管理

  end

  #GET
  #適応的思考
  def think_adaptively
    #step4の実行
    @user = current_user
    @automatic_thought.given_time_feeling.progress_step_4() #状態管理

  end

  #完了する
  def progress_finished
    @automatic_thought.given_time_feeling.progress_finished() #状態管理
    render layout: false
    #code
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_automatic_thought
      @automatic_thought = AutomaticThought.find(params[:id])
      logger.debug("@automatic_thought.contents = " + @automatic_thought.contents)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def automatic_thought_params
      params.require(:automatic_thought).permit(:contents, :given_time_feeling_id)
    end
end
