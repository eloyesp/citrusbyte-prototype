require 'cuba'
require 'mote'
require 'mote/render'

Cuba.plugin(Mote::Render)

Cuba.define do
  on root do
    render 'admin_dashboard'
  end
end
