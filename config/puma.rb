require 'pathname'

threads 8,32
workers 2

rails_root = Pathname.new(File.dirname(__FILE__)).join('..')
logs_path = rails_root.join('log')
tmp_path = rails_root.join('tmp')

socket_path = tmp_path.join('sockets', 'healthymerpg-puma.sock')
state_path = tmp_path.join('sockets', 'healthymerpg-puma.state')
pidfile_path = tmp_path.join('pids', 'healthymerpg-puma.pid')

bind "unix://#{socket_path.realdirpath}"
state_path state_path.realdirpath
pidfile pidfile_path.realdirpath

stdout_redirect logs_path.join('puma-stdout.log'), logs_path.join('puma-stderr.log'), true

environment ENV['RAILS_ENV'] || 'development'

preload_app!
