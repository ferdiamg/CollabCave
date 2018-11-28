module BeatsHelper
  def like_button_tag(beat, previous_like)
    return link_to '', beat_like_path(beat, previous_like), method: :delete, remote: true, class: "fa fa-heart" if previous_like
    link_to '', beat_likes_path(beat), method: :post, remote: true, class: "fa fa-heart"
  end
end
