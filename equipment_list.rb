module Jekyll

  class EquipmentIndex < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir  = dir
      @name = "index.html"

      self.read_yaml(File.join(base, '_layouts'), 'equipment.html')
      self.data['equipment'] = self.get_equipment(site)
      self.process(@name)
    end

    def get_equipment(site)
      [].tap do |equipment|
        Dir['_equipment/*.yml'].each do |path|
          name   = File.basename(path, '.yml')
          equipment << YAML.load(File.read(File.join(@base, path)))
        end
      end
    end
  end

  class GenerateEquipmentList < Generator
    safe true
    priority :normal

    def generate(site)
      equipment = EquipmentIndex.new(site, site.source, "/getredi/equipment/")
      equipment.render(site.layouts, site.site_payload)
      equipment.write(site.dest)

      site.pages << equipment
      site.static_files << equipment
    end
  end
end