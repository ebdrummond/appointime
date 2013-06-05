module UsersHelper
  def formatted_phone(number)
    n = number.split("")
    area_code = n[0..2].join
    first = n[3..5].join
    last = n[6..10].join
    "(#{area_code}) #{first}-#{last}"
  end
end
