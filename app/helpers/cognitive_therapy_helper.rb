module CognitiveTherapyHelper
  def disabled(id, ids)
    return true if ids.include?(id)
    return false
  end
end
