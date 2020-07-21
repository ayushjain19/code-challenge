class Company < ApplicationRecord
  has_rich_text :description
  validates :email, :format => { :with => /\A([^@\s]+)@getmainstreet\.com\z/,
  								:message => "Email domain should be @getmainstreet.com" }, :allow_blank => true

end
