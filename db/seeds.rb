admin_user = [
  {id: 1, login_id: "admin001", password: "admin001!", password_confirmation: "admin001!", status: 1, created_at: Time.current, updated_at: nil},
  {id: 2, login_id: "day_one_partners", password: "jQ4!pR@9zW1mL^5d", password_confirmation: "jQ4!pR@9zW1mL^5d", status: 1, created_at: Time.current, updated_at: nil},
]

categories = [
  {id: 1, name: "花屋", created_at: Time.current, updated_at: nil},
  {id: 2, name: "美容院", created_at: Time.current, updated_at: nil},
  {id: 3, name: "居酒屋", created_at: Time.current, updated_at: nil},
]

AdminUser.create!(admin_user)
Category.create!(categories)
