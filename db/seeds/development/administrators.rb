Administrator.create!(
  email: "hanako@example.com",
  password: "password",
  password_confirmation: "password"
)

Administrator.create!(
  email: "hanao@example.com",
  password: "password",
  password_confirmation: "password",
  suspended: true
)
