module BeatsHelper
  def like_button_tag(beat, previous_like)
    return button_to 'Unlike', beat_like_path(beat, previous_like), method: :delete, remote: true if previous_like
    button_to 'Like', beat_likes_path(beat), method: :post, remote: true
  end
end
