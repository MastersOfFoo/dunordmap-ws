class Building
  include ActiveModel::Model

  attr_accessor :name, :photo_url, :history, :updated_at

  def self.all
    @buildings ||= begin
      buildings = []
      ['Bloque A', 'Bloque B', 'Bloque C'].each do |name|
        buildings << Building.new(name: name, updated_at: Time.now)
      end
      buildings
    end
  end

  def self.find(id)
    all[id.to_i-1]
  end
end