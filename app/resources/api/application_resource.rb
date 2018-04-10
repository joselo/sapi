class Api::ApplicationResource < JSONAPI::Resource
  abstract

  def self.creatable_fields(context)
    super - self.read_fields
  end
end
