module BeatsHelper
  def like_button_tag(beat, previous_like)
    return link_to image_tag("heart_filled.svg"), beat_like_path(beat, previous_like), method: :delete, remote: true, class: "icon" if previous_like
    link_to image_tag("heart_empty.svg"), beat_likes_path(beat), method: :post, remote: true, class: "icon"
  end
end
