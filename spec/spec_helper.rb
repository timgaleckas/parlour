# typed: ignore
require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'parlour'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def suppress_stdout
  prev_stdout = $stdout
  $stdout = StringIO.new
  yield
rescue StandardError
  $stdout = prev_stdout
end

def fix_heredoc(x)
  lines = x.lines
  /^( *)/ === lines.first
  indent_amount = $1.length
  lines.map do |line|
    /^ +$/ === line[0...indent_amount] \
      ? line[indent_amount..-1]
      : line
  end.join.rstrip
end