class TopController < ApplicationController
  def index
    @cognitive_distortions = CognitiveDistortion.all
  end
end
