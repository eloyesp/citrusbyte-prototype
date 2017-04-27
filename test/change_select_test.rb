require "cuba/test"
require_relative "../smart_house_manager"

scope do
  test "change the options of a select control" do
    post '/admin/device_types/1/controls/3/', name: "Playlist",
      config: { options: "Lonely Day, Other option" }
    assert_equal Control[3].config[:options], ["Lonely Day", "Other option"]
  end
end
