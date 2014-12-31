module PeopleHelper

  def role_label(role)
    style = role.color.present? ? "background-color: #{role.color}" : nil

    content_tag :span, role.name, class: "label label-default", style: style
  end

end
