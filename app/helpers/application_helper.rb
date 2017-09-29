module ApplicationHelper

  def nav_link(text, path, opts = {})
    content_tag(:li, class: ['nav-item', current_page?(path) ? 'active' : ''].join(' ')) do
      link_to text, path, {class: 'nav-link'}.merge(opts)
    end
  end

end
