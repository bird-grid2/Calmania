require 'clockwork'
require 'active_support/time'
require './config/boot'
require './config/environment'


module Clockwork

  # required to enable database syncing support
  Clockwork.manager = DatabaseEvents::Manager.new




end