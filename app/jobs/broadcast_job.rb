class BroadcastJob < ApplicationJob
  queue_as :broadcast

  

  def perform(elem, num)
    $container = elem
    $timer = num
  end
end
