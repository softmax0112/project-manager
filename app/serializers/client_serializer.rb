# frozen_string_literal: true

class ClientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :affiliation
  has_many :projects
end
