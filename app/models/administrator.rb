class Administrator < ApplicationRecord
  include EmailHolder
  include PasswordHolder

  authenticates_with_sorcery!
end
