def colorize(text, color_code)
  "\033[#{color_code}m#{text}\033[0m"
end
 
{
  :black    => 30,
  :red      => 31,
  :green    => 32,
  :yellow   => 33,
  :blue     => 34,
  :magenta  => 35,
  :cyan     => 36,
  :white    => 37
}.each do |key, color_code|
  define_method key do |text|
    puts colorize(text, color_code)
  end
end

namespace :mixins do
  desc "Generates new bootstrap mixins list"
  task generate: :environment do

    gem_spec = Gem.loaded_specs['bootstrap-sass']
    gem_path = gem_spec.full_gem_path
    assets_path = Pathname.new(File.join(gem_path, 'vendor', 'assets', 'stylesheets'))
    assets_files = Dir[File.join(assets_path, '**', '*.scss')]

    result = {
      bootstrap_gem_version: gem_spec.version,
      mixins: {}
    }

    assets_files.each do |asset_file|
      yellow "Parsing #{File.basename(asset_file)}"
      File.foreach(asset_file).inject(1) do |index, line|
        line.scan(/@mixin ([^{]*)\s+{/).flatten.each do |mixin| 
          filename = Pathname.new(asset_file).relative_path_from(assets_path).to_s

          result[:mixins][filename] ||= []
          result[:mixins][filename] << { 
            path: asset_file,
            filename: filename,
            line: index, 
            content: mixin 
          } 
        end
        index += 1
      end
    end

    result[:generated_at] = Time.now

    save_path = File.join(Rails.root, 'lib', 'database.json')
    File.open(save_path, 'w') { |file| file.write(result.to_json) }

    green "Completed and saved to #{save_path}"
  end
end
