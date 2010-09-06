# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :prompt do |prompt|
  prompt.text "What is your favorite color?"
end

Factory.sequence :prompt_text do |n|
  sequence = [
    "What is your name?",
    "What is your quest?",
    "What is your favorite color?"
  ]
  return sequence[n % sequence.length]
end

Factory.define :answer do |answer|
  answer.content "My favorite color is red... no, blue!"
end

Factory.define :invite do |invite|
  invite.name "Miles Davis"
  invite.giver_name "Clifford Brown"
  invite.email "mdavis@memoirable.com"
  invite.message "Hey pops, please take this opportunity to tell me your life story.\n\n  Thanks,\nDavid"
end
