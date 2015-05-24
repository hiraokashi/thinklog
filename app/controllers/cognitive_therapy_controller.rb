class CognitiveTherapyController < ApplicationController
  def therapy_start
    @feelings = Feeling.all
  end
end
