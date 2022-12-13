class Administrator < ApplicationRecord
  authenticates_with_sorcery!
end
