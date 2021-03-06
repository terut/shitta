worker_processes 2

service = "shitta"
address = ENV['WITH_HTTP'] ? 8080
                           : "/tmp/#{service}.unicorn.sock"
app_path = "/var/www/#{service}/current"
working_directory app_path

listen address, :backlog => 64
pid 'tmp/pids/unicorn.pid'

timeout 30

stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and GC.copy_on_write_friendly = true

check_client_connection false

before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{app_path}/Gemfile"
  Dotenv.overload
end

run_once = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  if run_once
    # do_something_once_here ...
    run_once = false # prevent from firing again
  end

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
