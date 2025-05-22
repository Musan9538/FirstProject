# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 既存のデータを削除
Harvest.destroy_all
User.destroy_all

# 管理者ユーザーの作成
admin = User.create!(
  username: "admin",
  password: "admin",
  password_confirmation: "admin",
  is_admin: true
)

# 一般ユーザーの作成
user = User.create!(
  username: "user1",
  password: "password",
  password_confirmation: "password",
  is_admin: false
)

# サンプルデータの作成
[admin, user].each do |u|
  3.times do |i|
    u.harvests.create!(
      date: Date.today - i.days,
      amount: rand(50.0..100.0).round(1)
    )
  end
end
