class RequestSerializer
  include FastJsonapi::ObjectSerializer

  has_many :trips

  attributes :id,
             :updated_at

end
