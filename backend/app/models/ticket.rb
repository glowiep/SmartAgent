class Ticket < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many_attached :attachments
  belongs_to :agent
  belongs_to :status
end
