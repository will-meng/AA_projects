class Cat < ApplicationRecord

COLORS = %w[black white brown green blue red orange yellow purple]
SEX = ["M", "F"]

validates :birth_date, :name, :sex, presence: true
validates :color, inclusion: { in: COLORS, message: "cats can't be that color!"}
validates :sex, inclusion: { in: SEX, message: "There's only two sexes!"}

has_many :cat_rental_requests,
primary_key: :id,
foreign_key: :cat_id,
class_name: :CatRentalRequest,
dependent: :destroy

def age
  d = Date.today
  birth = self.birth_date

  age = d.year - birth.year

  d_mo = d.month
  b_mo = birth.month

  age -=1 if d_mo < b_mo || d_mo == b_mo && d.day < b.day
end

def colors
  COLORS
end

def sexes
  SEX
end

end
