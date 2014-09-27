require 'pathname'

threads 8,32
workers 2

tmp_path = Pathname.new(File.dirname(__FILE__)).join('..', 'tmp')

socket_path = tmp_path.join('sockets', 'healthymerpg-puma.sock')
state_path = tmp_path.join('sockets', 'healthymerpg-puma.state')
pidfile_path = tmp_path.join('pids', 'healthymerpg-puma.pid')

bind "unix://#{socket_path.realdirpath}"
state_path state_path.realdirpath
pidfile pidfile_path.realdirpath

environment ENV['RAILS_ENV'] || 'development'

preload_app!
