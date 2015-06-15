module SituationsHelper
  def path_for_modal_form(method, situation)
    path = ''
    if method == "post"
      path = '/situations'
    else
      path = '/situations/' + situation.id.to_s
    end
    return path
  end
end
