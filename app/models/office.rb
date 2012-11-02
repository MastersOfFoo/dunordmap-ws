class Office
  include ActiveModel::Model

  attr_accessor :name, :updated_at

  def self.all
    @offices ||= begin
      offices = []
      ['Departamento de Sistemas', 'Departamento de Civil', 'Almacen KM5', 'Departamento de Derecho'].each do |name|
        offices << Office.new(name: name, updated_at: Time.now)
      end
      offices
    end
  end
end
