class HomeController < ApplicationController
  def index
    # Unfortunately bootstrap-sass team doesn't use standard master/devel branching convention
    # making it impossible to simply link to master with gem's stable version.
    # Also their tagging convention is not 1:1 with their gem versioning convention.

    current_version_url = 'https://github.com/twbs/bootstrap-sass/tree/v3.3.1'
    json = JSON.parse(File.read(File.join(Rails.root, 'lib', 'database.json')))
    json_hash = HashWithIndifferentAccess.new(json)
    render :locals => { url: current_version_url, json: HashWithIndifferentAccess.new(json) }
  end
end
