class User < ApplicationRecord
  enum :score, { A: 0, B: 1, C: 2, D: 3, F: 4 }
end
