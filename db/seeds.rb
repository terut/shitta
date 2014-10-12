admins = ['admin']
admins.each do |admin|
  user = User.find_by_username(admin)
  if user.present?
    user.update_attributes!(admin: true)
  else
    puts "#{admin} doesn't exist."
  end
end

Note.all.each do |note|
  Note.reset_counters(note.id, :comments)
end
