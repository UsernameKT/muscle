json.array! @posts do |post|
  json.id post.id
  json.title post.title
  json.start post.created_at

  json.color case post.category
  when "upper"
    "#ff6b6b"
  when "lower"
    "#4dabf7"
  when "running"
    "#51cf66"
  when "bodyweight"
    "#ffd43b"
  when "stretch"
    "#20c997"
  when "rest"
    "#adb5bd"
  else
    "#adb5bd"
  end
end