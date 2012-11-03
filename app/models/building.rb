class Building
  include ActiveModel::Model

  attr_accessor :name, :photo_url, :history, :updated_at

  def self.all
    @buildings ||= begin
      buildings = []
      ['Bloque A', 'Bloque B', 'Bloque C'].each do |name|
        buildings << Building.new(name: name, updated_at: Time.now, photo_url: 'http://webdepotstudios.com/jesdis/fotos/bienestar.png')
      end
      buildings
    end
  end

  def self.near(lat, lon)
    buildings = []
    response = RestClient.get("#{SERVER_URL}/HelloWorld/resources/Uninorte/getCercanos?pos=#{lon}%20#{lat}")
    buildings_info = JSON.parse(response)
    buildings_info.each do |building_id|
      building = Rails.cache.fetch("buildings_#{building_id}", :expires_in => 1.day) do
        resp = RestClient.get("#{SERVER_URL}/HelloWorld/resources/Uninorte/getInformacion?id=#{building_id}")
        building_info = JSON.parse(resp)
        Building.new(name: building_info["nombre"], updated_at: Time.now, photo_url: building_info["foto"])
      end
      buildings << building
    end
    buildings
  end

  def self.find(id)
    all[id.to_i-1]
  end

  def offices
    Office.all
  end
end
