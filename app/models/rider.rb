require "validates_email_format_of"
require "acts_as_list"
require "team"

class Rider < ActiveRecord::Base
  def self.paid
    where(paid: true)
  end

  belongs_to :team
  belongs_to :user, required: false
  acts_as_list scope: :team_id

  validates_email_format_of :email, allow_blank: true

  def team_position
    team.try(:position)
  end

  alias_attribute :shirt_size, :shirt

  def autocomplete_options
    User.all.map do |user|
      { 
        verified: user.verified?,
        label: "#{user.name} ‹#{user.email}›",
        value: user.id,
        user_id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        shirt_size: user.shirt_size,
      }
    end
  end
end
