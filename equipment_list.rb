module Jekyll

  class GenerateEquipmentList < Generator
    safe true
    priority :normal

    def generate(site)
      @site = site

      equipment = {}

      Dir['_equipment/*.yml'].each do |path|
        name   = File.basename(path, '.yml')
        data = YAML.load(File.read(path))
        equipment[name] = data
      end

      @site.data['equipment'] = equipment

    end
  end
end