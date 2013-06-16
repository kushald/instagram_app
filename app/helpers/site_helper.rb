module SiteHelper
  def pin
    {
      :u => "//pinterest.com/pin/create/button/?url=#{request.protocol+request.host_with_port+request.fullpath}",
      :s => "//assets.pinterest.com/images/pidgets/pin_it_button.png",
      :d => "Joystagram:",
      :do => "buttonPin",
      :c => "none"
    }
  end
end
