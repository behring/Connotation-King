class ClientUser < ActiveRecord::Base
  validates_uniqueness_of :token,:email
end