class Task < ApplicationRecord

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  validates :name, presence: true, length: { maximum: 30}
  validate :validate_name_not_including_comma

  private

  def validate_name_not_including_comma
    errors.add(:name, "にカンマを含めることができません。") if name&.include?(",")
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description"]
  end
end
