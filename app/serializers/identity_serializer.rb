class IdentitySerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :access_token
end
