module ApplicationHelper
  def modal_links_for(resource, delimiter: ' | ')
    link_to(t('.up_vote'), '')+ delimiter +
    link_to(t('.down_vote'), '') + delimiter
  end
end
